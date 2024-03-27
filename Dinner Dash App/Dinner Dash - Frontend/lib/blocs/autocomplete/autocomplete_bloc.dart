import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/models/place_autocomplete_model.dart';
import 'package:flutter_app/repositories/places/places_repo.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

/*class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? _placesSubscription;

  AutocompleteBloc({required PlacesRepository placesRepository})
    : _placesRepository = placesRepository,
      super(AutocompleteLoading()){
        on<LoadAutocomplete>(_onLoadAutocomplete);
        on<ClearAutocomplete>(_onClearAutocomplete);
      }

  void _onLoadAutocomplete(
        LoadAutocomplete event,
        Emitter<AutocompleteState> emit,
      ) async {
          final List<PlaceAutocomplete> autocomplete =
            await _placesRepository.getAutocomplete(event.searchInput);

          emit (AutocompleteLoaded(autocomplete: autocomplete));
    }

    void _onClearAutocomplete(
      ClearAutocomplete event,
      Emitter<AutocompleteState> emit,
    ){
      emit(AutocompleteLoaded(autocomplete: List.empty()));
    }

    @override
    Future<void> close() async {
      _placesSubscription?.cancel();
      super.close();
    }
}
*/


class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? _placesSubscription;

  AutocompleteBloc({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(AutocompleteLoading()) {
    on<LoadAutocomplete>(_onLoadAutocomplete);
    on<ClearAutocomplete>(_onClearAutocomplete);
  }

  /*void _onLoadAutocomplete(
      LoadAutocomplete event,
      Emitter<AutocompleteState> emit,
  ) async {
    try {
      final List<PlaceAutocomplete> autocomplete =
          await _placesRepository.getAutocomplete(event.searchInput);

      emit(AutocompleteLoaded(autocomplete: autocomplete));
    } catch (error, stackTrace) {
      // Handle the error state or log the error
      onError(error, stackTrace);
    }
  }//put this back in a min - search box not showing eith this 

  ///this is kind of working - displays the search bar
  void _onLoadAutocomplete(
    LoadAutocomplete event,
    Emitter<AutocompleteState> emit,
) async {
  await Future.delayed(Duration(seconds: 1));  // Simulate some delay
  final List<PlaceAutocomplete> autocomplete = [];  // Use mock data
  emit(AutocompleteLoaded(autocomplete: autocomplete));
}*/

void _onLoadAutocomplete(
  LoadAutocomplete event,
  Emitter<AutocompleteState> emit,
) async {
  try {
    final List<PlaceAutocomplete> autocomplete =
        await _placesRepository.getAutocomplete(event.searchInput);

    emit(AutocompleteLoaded(autocomplete: autocomplete));
  } catch (error) {
    // Optionally, emit an error state if there's an exception
    emit(
      AutocompleteError("Failed to load autocomplete suggestions"));
  }
}




  void _onClearAutocomplete(
    ClearAutocomplete event,
    Emitter<AutocompleteState> emit,
  ) {
    emit(AutocompleteLoaded(autocomplete: List.empty()));
  }

  @override
  Future<void> close() async {
    _placesSubscription?.cancel();
    return super.close();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // Log the error and stack trace
    print('AutocompleteBloc Error: $error');
    print('Stack Trace: $stackTrace');
    super.onError(error, stackTrace);
  }
}
