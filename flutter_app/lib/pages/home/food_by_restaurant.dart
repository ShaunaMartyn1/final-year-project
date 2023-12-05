import 'package:flutter/material.dart';

import '../../data_service/food_service.dart';

class FoodByRestaurant extends StatefulWidget {
  final String restaurantName;
  const FoodByRestaurant({
    Key? key, 
    required this.restaurantName,   //check this required this.foodService, required this.size
  }) : super(key: key);

  //final FoodService foodService;
  //final Size size;

  @override
  State<FoodByRestaurant> createState() => _FoodByRestaurantState();
}

class _FoodByRestaurantState extends State<FoodByRestaurant> {
  FoodService foodService = FoodService();
  late List<Food> foods;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<ListOfFood>(
        future: foodService.getFoodByRestaurant(widget.restaurantName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Food> foods = snapshot.data!.foods;
            return Container(
              margin: EdgeInsets.all(20),
              height: size.height,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Products",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      ...foods.map((food) {
                        return Container(
                          margin: EdgeInsets.all(12.0), //10
                          height: size.height *
                              0.26, //size of boxes that food items are in
                          width: size.width * 0.20, //20
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                food.name,
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("${food.price}",
                                      style: TextStyle(
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough)),
                                  Text("${food.price_with_discount}"),
                                ],
                              ),
                              Image.memory(
                                food.image_memory,
                                height: size.height * 0.11,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(),
                                  onPressed: () {},
                                  child: Text(
                                    "Add to Cart",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container(
              margin: EdgeInsets.all(20),
              height: size.height,
              width: double.infinity,
              color: Colors.white,
              child: CircularProgressIndicator());
        });
  }
} //main