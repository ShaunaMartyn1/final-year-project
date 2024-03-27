import 'package:flutter_app/models/place_model.dart';
import 'package:flutter_app/models/restaurant_model.dart';

abstract class BaseRestaurantRepository {
  Stream<List<Restaurant>> getRestaurants();
  Stream<List<Restaurant>> getNearbyRestaurants(Place selectedAddress);

}