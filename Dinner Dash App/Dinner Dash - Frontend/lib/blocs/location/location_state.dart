part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  
  @override
  List<Object?> get props => [];
}

final class LocationLoading extends LocationState {}

final class LocationLoaded extends LocationState {
  final GoogleMapController? controller;
  final Place place;
  final List<Restaurant>? restaurants;

  LocationLoaded({
    this.controller,
    this.restaurants,
    required this.place,
  });

  @override
  List<Object?> get props => [controller,restaurants, place];
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);

  @override
  List<Object> get props => [message];
}