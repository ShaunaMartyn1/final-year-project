import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dinnerdashbackend/models/opening_hours_model.dart';
import 'package:dinnerdashbackend/models/restaurant_model.dart';
import 'package:dinnerdashbackend/repos/restaurant/restaurant_repo.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final RestaurantRepo _restaurantRepo;
  StreamSubscription? _restaurantSubscription;


  SettingsBloc({required RestaurantRepo restaurantRepo}) 
      : _restaurantRepo = restaurantRepo,
        super(SettingsLoading()) {
    
    on<LoadSettings>(_onLoadSettings);
    on<UpdateSettings>(_onUpdateSettings);
    on<UpdateOpeningHours>(_onUpdateOpeningHours);

    _restaurantSubscription = _restaurantRepo.getRestaurant().listen((restaurant) {
      print(restaurant);
      add(LoadSettings(restaurant: restaurant));
    });
  }

  void _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit
    ) async{
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(SettingsLoaded(event.restaurant));
    }
    
  void _onUpdateSettings(
    UpdateSettings event,
    Emitter<SettingsState> emit,
    ) {
      emit(SettingsLoaded(event.restaurant));
    }

  void _onUpdateOpeningHours(
    UpdateOpeningHours event,
    Emitter<SettingsState> emit,
    ) {
      final state = this.state;

      if (state is SettingsLoaded){
        List<OpeningHours> openingHoursList = (
          state.restaurant.openingHours!.map((openingHours){
          return openingHours.day == event.openingHours.id
          ? event.openingHours
          : openingHours;
        })).toList();

        emit(SettingsLoaded(
          state.restaurant.copyWith(openingHours: openingHoursList)
        ));
      }
    }

    @override
    Future<void> close() {
      _restaurantSubscription?.cancel();
      return super.close();
    }
}
  

