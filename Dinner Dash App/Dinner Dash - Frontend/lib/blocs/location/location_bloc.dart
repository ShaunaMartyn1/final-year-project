import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/place_model.dart';
import 'package:flutter_app/repositories/local_storage/local_storage_repository.dart';
import 'package:flutter_app/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final PlacesRepository _placesRepository;
  final GeolocationRepository _geolocationRepository;
  final LocalStorageRepository _localStorageRepository;
  StreamSubscription? _placesSubscription;
  StreamSubscription? _geolocationSubscription;

  LocationBloc({
    required PlacesRepository placesRepository,
    required GeolocationRepository geolocationRepository,
    required LocalStorageRepository localStorageRepository,
  })  : _geolocationRepository = geolocationRepository,
        _placesRepository = placesRepository,
        _localStorageRepository = localStorageRepository,
        super(LocationLoading()) {
    on<LoadMap>(_onLoadMap);
    on<SearchLocation>(_onSearchLocation);
  }

  void _onLoadMap(
    LoadMap event,
    Emitter<LocationState> emit,
  ) async {
    Box box = await _localStorageRepository.openBox();
    final Place? place = _localStorageRepository.getPlace(box);

    if (place == null) {
      print('place is null');

      final Position position =
          await _geolocationRepository.getCurrentLocation();

      emit(
        LocationLoaded(
          controller: event.controller,
          place: Place(
            lat: position.latitude,
            lon: position.longitude,
          ),
        ),
      );
    } else {
      emit(
        LocationLoaded(
          controller: event.controller,
          place: place,
        ),
      );
    }
  }

  void _onSearchLocation(
    SearchLocation event,
    Emitter<LocationState> emit,
  ) async {
    final state = this.state as LocationLoaded;
    final Place? place = await _placesRepository
        .getPlace(event.placeId); //added ? to place to fix error

    if (place == null) {
      emit(LocationLoaded(
        controller: state.controller,
        place: state.place,
      ));
    } else {
      Box box = await _localStorageRepository.openBox();
      _localStorageRepository.clearBox(box);
      _localStorageRepository.addPlace(box, place);

    state.controller!.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          place.lat,
          place.lon,
        ),
      ),
    );

    emit(
      LocationLoaded(
        controller: state.controller,
        place: place,
    ));
    }
  }

  @override
  Future<void> close() async {
    _placesSubscription?.cancel();
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
