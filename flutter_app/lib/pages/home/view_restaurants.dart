
import 'package:flutter/material.dart';
import 'package:flutter_app/data_service/food_service.dart';
import 'package:flutter_app/pages/home/food_by_restaurant.dart';



class ViewRestaurants extends StatefulWidget {
  const ViewRestaurants({Key? key}) : super(key: key);

  @override
  State<ViewRestaurants> createState() => _ViewRestaurantState();
}

class _ViewRestaurantState extends State<ViewRestaurants> {
  FoodService foodService = FoodService();
  bool showFoodRestaurant = false;
  late List<Restaurant> restaurants;
  String restaurantName = "";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RestaurantList>(
        future: foodService.getRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            restaurants = snapshot.data!.restaurants;
            return Container(
                child: showFoodRestaurant
                    ? FoodByRestaurant(///check this food by restaurant
                        restaurantName: restaurantName,//added parameters
                      )
                      : Column(
                        children: restaurants
                            .map((restaurant) => Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: InkWell(
                                    onTap: () {
                                      restaurantName = restaurant.name;
                                      showFoodRestaurant = true;
                                      setState(() {});
                                    },
                                    child: Text(
                                      restaurant.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(), //check was restaurant with error
                      )
                    );
          }
          if (snapshot.hasError) {
            print("Error: ${snapshot.error}"); //getting null
          }
          return CircularProgressIndicator();
        });
  }
}

