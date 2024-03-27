import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/models/place_model.dart';
import 'package:flutter_app/models/restaurant_model.dart';
import 'package:flutter_app/repositories/restaurant/base_restaurant_repository.dart';
import 'package:geolocator/geolocator.dart';

class RestaurantRepository extends BaseRestaurantRepository{
  final FirebaseFirestore _firebaseFirestore;

  RestaurantRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  
  @override
  Stream<List<Restaurant>> getRestaurants() {
    return _firebaseFirestore
      .collection('restaurants')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs
          .map((doc) => Restaurant.fromSnapshot(doc))
          .toList();
      });
    }
    
      @override
      Stream<List<Restaurant>> getNearbyRestaurants(
        Place selectedAddress
        ) {
        Stream<List<Restaurant>> restaurants = getRestaurants();
      
      return restaurants
      .map((restaurants){
        return restaurants 
        .where((restaurant) =>
        _getRestaurantDistance(
          restaurant.address,
          selectedAddress
          ) <=
          10)
        .toList();
      });
      
  }

  int _getRestaurantDistance(
    Place restaurantAddress, 
    Place selectedAddress
    ) {
      GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
      var distanceInKm = geolocator.distanceBetween(
        restaurantAddress.lat.toDouble(),
        restaurantAddress.lon.toDouble(),
        selectedAddress.lat.toDouble(),
        selectedAddress.lon.toDouble(),
      ) ~/ 1000;
    
    return (distanceInKm / 1000).round();  // Convert to kilometers and round off
  }

}