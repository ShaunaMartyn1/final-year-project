import 'package:flutter/material.dart';
import 'package:flutter_app/data_service/food_service.dart';
//21.46

class ViewRestaurants extends StatefulWidget {
  const ViewRestaurants({Key? key}) : super(key: key);

  @override
  State<ViewRestaurants> createState() => _ViewRestaurantState();
}

class _ViewRestaurantState extends State<ViewRestaurants> {
  FoodService foodService = FoodService();
  late List<Restaurant> restaurants;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RestaurantList>(
        future: foodService.getRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            restaurants = snapshot.data!.restaurants;
            return Container(
                child: Column(
              children: restaurants
                  .map((restaurant) => Text(restaurant.name))
                  .toList(), //check was category with error
            ));
          }
          if (snapshot.hasError) {
            print("API Response: ${snapshot.data}");
          }
          return CircularProgressIndicator();
        });
  }
}
