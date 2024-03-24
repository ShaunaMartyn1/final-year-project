part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
  
  @override
  List<Object> get props => [];
}

final class RestaurantLoading extends RestaurantState {}

final class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  RestaurantLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}