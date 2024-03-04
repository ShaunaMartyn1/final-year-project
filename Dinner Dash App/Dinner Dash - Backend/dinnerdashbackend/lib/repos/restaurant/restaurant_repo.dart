import 'package:dinnerdashbackend/models/opening_hours_model.dart';
import 'package:dinnerdashbackend/models/product_model.dart';
import 'package:dinnerdashbackend/models/restaurant_model.dart';
import 'package:dinnerdashbackend/repos/restaurant/base_restaurant_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RestaurantRepo extends BaseRestaurantRepo{
  final FirebaseFirestore _firebaseFirestore;

  RestaurantRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  
  @override
  Future<void> addRestaurant(Restaurant restaurant)async {
    await _firebaseFirestore
      .collection('restaurants')
      .add(restaurant.toDocument());
  }

  @override
  Future<void> editProducts(List<Product> products) async {
    await _firebaseFirestore
      .collection('restaurants')
      .doc('LyXqruY9ud3ni3RtzJzf')
      .update({'products': products.map((product) {
        return product.toDocument();
      }).toList()
    });
  }

  @override
  Future<void> editRestaurantOpeningHours(List<OpeningHours> openingHours)async  {
    await _firebaseFirestore
      .collection('restaurants')
      .doc('LyXqruY9ud3ni3RtzJzf')
      .update({'openingHours': openingHours.map((openingHours) {
        return openingHours.toDocument();
      }).toList()
    });
  }

  @override
  Future<void> editRestaurantSettings(Restaurant restaurant) async {
    await _firebaseFirestore.collection('restaurants')
      .doc('LyXqruY9ud3ni3RtzJzf')
      .update(restaurant.toDocument());
  }

  @override
  Stream<Restaurant> getRestaurant() {
    return _firebaseFirestore
      .collection('restaurants')
      .doc('LyXqruY9ud3ni3RtzJzf')
      .snapshots()
      .map((snapshot){ return Restaurant.fromSnapshot(snapshot);
    });
  }

}