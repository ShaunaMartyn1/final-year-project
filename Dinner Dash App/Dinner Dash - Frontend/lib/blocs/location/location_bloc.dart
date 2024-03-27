/*import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/place_model.dart';
import 'package:flutter_app/models/restaurant_model.dart';
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
  final RestaurantRepository _restaurantRepository;
  
  StreamSubscription? _placesSubscription;
  StreamSubscription? _geolocationSubscription;
  StreamSubscription? _restaurantSubscription;

  LocationBloc({
    required PlacesRepository placesRepository,
    required GeolocationRepository geolocationRepository,
    required LocalStorageRepository localStorageRepository,
    required RestaurantRepository restaurantRepository,
  })  : _geolocationRepository = geolocationRepository,
        _placesRepository = placesRepository,
        _localStorageRepository = localStorageRepository,
        _restaurantRepository = restaurantRepository,
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
      
      place = Place(
        lat: position.latitude,
        lon: position.longitude
      );
    }
    List<Restaurant> restaurants = await _getNearbyRestaurants(place);
      emit(
        LocationLoaded(
          controller: event.controller,
          place: place,
          restaurants: restaurants,
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

    
      Box box = await _localStorageRepository.openBox();
      _localStorageRepository.clearBox(box);
      _localStorageRepository.addPlace(box, place);

    state.controller!.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(place.lat, place.lon,),
      ),
    );

    List<Restaurant> restaurants = await _getNearbyRestaurants(place);

    emit(
      LocationLoaded(
        controller: state.controller,
        place: place,
        restaurants: restaurants,
    ));
  }
  

  Future<List<Restaurant>> _getNearbyRestaurants(
    Place place
    ) async {
      List<Restaurant> restaurants = 
        await _restaurantRepository.getRestaurants().first;

        return restaurants
        .where
        ((restautant) =>
          _getRestaurantDistance(
            restautant.address,
            place,
          ) <=
          10)
        .toList();
        
  }

  int _getRestaurantDistance(
    Place restaurantAddress,
    Place selectedAddress,
  ){
    GeolocatorPlatform geolocator = GeolocatorPlatform.instance;

    var distanceInKm = geolocator.distanceBetween(
      restaurantAddress.lat.toDouble(),
      restaurantAddress.lon.toDouble(),
      selectedAddress.lat.toDouble(),
      selectedAddress.lon.toDouble(),
    )~/
    1000;

    return distanceInKm;
  }

  @override
  Future<void> close() {
    _placesSubscription?.cancel();
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
*/ ///////////////old

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/place_model.dart';
import 'package:flutter_app/models/restaurant_model.dart';
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
  final RestaurantRepository _restaurantRepository;

  StreamSubscription? _placesSubscription;
  StreamSubscription? _geolocationSubscription;
  StreamSubscription? _restaurantSubscription;

  LocationBloc({
    required PlacesRepository placesRepository,
    required GeolocationRepository geolocationRepository,
    required LocalStorageRepository localStorageRepository,
    required RestaurantRepository restaurantRepository,
  })  : _placesRepository = placesRepository,
        _geolocationRepository = geolocationRepository,
        _localStorageRepository = localStorageRepository,
        _restaurantRepository = restaurantRepository,
        super(LocationLoading()) {
    on<LoadMap>(_onLoadMap);
    on<SearchLocation>(_onSearchLocation);
  }

  void _onLoadMap(
    LoadMap event,
    Emitter<LocationState> emit,
  ) async {
    try {
      Box box = await _localStorageRepository.openBox();
      Place? place = _localStorageRepository.getPlace(box);

      if (place == null) {
        final Position position =
            await _geolocationRepository.getCurrentLocation();
        place = Place(lat: position.latitude, lon: position.longitude);
      }

      List<Restaurant> restaurants = await _restaurantRepository.getNearbyRestaurants(place).first;

      emit(LocationLoaded(
        controller: event.controller,
        place: place,
        restaurants: restaurants,
      ));
    } catch (e) {
      // Handle exceptions or emit an error state
      emit(LocationError("Error loading map"));
    }
  }

  void _onSearchLocation(
    SearchLocation event,
    Emitter<LocationState> emit,
  ) async {
    try {
      if (state is LocationLoaded) {
        final state = this.state as LocationLoaded;
        final Place? place = await _placesRepository.getPlace(event.placeId);

        if (place != null) {
          Box box = await _localStorageRepository.openBox();
          _localStorageRepository.clearBox(box);
          _localStorageRepository.addPlace(box, place);

          state.controller?.animateCamera(
            CameraUpdate.newLatLng(LatLng(place.lat, place.lon)),
          );

          List<Restaurant> restaurants =
              await _restaurantRepository.getNearbyRestaurants(place).first;

          emit(LocationLoaded(
            controller: state.controller,
            place: place,
            restaurants: restaurants,
          ));
        }
      }
    } catch (e) {
      // Handle exceptions or emit an error state
      emit(LocationError("Error searching for location"));
    }
  }

  /*Future<List<Restaurant>> _getNearbyRestaurants(Place place) async {
    List<Restaurant> restaurants = await _restaurantRepository.getRestaurants().first;
    return restaurants.where((restaurant) => _getRestaurantDistance(restaurant.address, place) <= 10).toList();
  }

  int _getRestaurantDistance(Place restaurantAddress, Place selectedAddress) {
    double distanceInMeters = Geolocator.distanceBetween(
      restaurantAddress.lat,
      restaurantAddress.lon,
      selectedAddress.lat,
      selectedAddress.lon,
    );
    return (distanceInMeters / 1000).round();  // Convert to kilometers and round off
  }*/

  @override
  Future<void> close() {
    _placesSubscription?.cancel();
    _geolocationSubscription?.cancel();
    _restaurantSubscription?.cancel();
    return super.close();
  }
}
