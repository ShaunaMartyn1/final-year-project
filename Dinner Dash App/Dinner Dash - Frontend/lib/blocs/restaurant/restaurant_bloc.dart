import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/restaurant_model.dart';
import 'package:flutter_app/repositories/restaurant/restaurant_repository.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository _restaurantRepository;
  StreamSubscription? _restaurantSubscription;

  RestaurantBloc({
    required RestaurantRepository restaurantRepository,
  })  : _restaurantRepository = restaurantRepository,
        super(RestaurantLoading()) {
    on<LoadRestaurants>(_onLoadRestaurants);

    _restaurantSubscription = _restaurantRepository
        .getRestaurants()
        .listen((restaurants) => add(LoadRestaurants(restaurants)));
  }
  void _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<RestaurantState> emit,
  ) {
    emit(RestaurantLoaded(event.restaurants));//take new restaurant list as an input
  }

  @override
  Future<void> close() async {
    _restaurantSubscription?.cancel();
    super.close();
  }
}
