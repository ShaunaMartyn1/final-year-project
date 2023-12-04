// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home/search_result_food.dart';
import 'package:flutter_app/pages/home/view_categories.dart';

import '../../data_service/food_service.dart';
import 'view_restaurants.dart';
import 'search_result_food.dart';

//52.56


enum ShowSelectedType{food, categories, restaurants, searchResult}
class Home extends StatefulWidget {
  const Home(); //changed this took out super.key

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ShowSelectedType showSelectedType = ShowSelectedType.food;//food or foods??? 14:23
  String searchingKeyword = "";
  @override
  void initState() {
    super.initState();
  }
//shoping cart icons, and sign in button 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFe6e6e6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        // ignore: prefer_const_constructors
        leading: InkWell(child: Icon(Icons.menu, color: Colors.black)),
        actions: [
          InkWell(
            child: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(),
              onPressed: () {},
              child: Text("Sign In", style: TextStyle()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: size.height * 0.1,
                width: double.infinity,
                child: TextField(
                  onChanged: (value) {
                    //do somehting with user input here
                    searchingKeyword = value;
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    hintText: 'Search',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showSelectedType = ShowSelectedType.searchResult;
                          });
                        },
                        child: Material(
                          color: Colors.blue,
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(
                  color: Colors.black38,
                ),
              ),
              height: size.height * 0.1, //0.7
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                //horizontal-scrollable row of containers, with text label and restaurant names
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.all(6.0), 
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(8.0), 
                        ),
                        child: Text("McDonalds"),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text("Supermacs"),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text("KFC"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, //space out categories
              children: [
                 ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    setState((){
                      showSelectedType = ShowSelectedType.food;//foods?
                    });
                  },
                  child: Text(
                    "Foods",
                    style: TextStyle(color: showSelectedType== ShowSelectedType.food //foods???
                      ? Colors.black54
                      : Colors.black87),
                  ),
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () { //if category button is clicked
                    setState((){
                    showSelectedType = ShowSelectedType.categories;
                    });
                  },
                  child: Text(
                    "Categories",
                    style: TextStyle( color: showSelectedType== ShowSelectedType.categories
                      ? Colors.black54
                      : Colors.black87),),
                  ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    setState((){
                    showSelectedType = ShowSelectedType.restaurants;
                    });
                  },
                  child: Text(
                    "Restaurants",
                    style: TextStyle(color: showSelectedType== ShowSelectedType.restaurants
                    ? Colors.black54
                    : Colors.black87),
                  ),
                ),
              ],
            ),
            if (showSelectedType == ShowSelectedType.food) ViewFoods(),
            if (showSelectedType == ShowSelectedType.categories) ViewCategories(),
            if (showSelectedType == ShowSelectedType.restaurants) ViewRestaurants(),
            if(showSelectedType == ShowSelectedType.searchResult) SearchResultFood(keyword: searchingKeyword, ),
          ],
        ),
      ),
    ); 
  }
}

class ViewFoods extends StatefulWidget {
  const ViewFoods({
    Key? key, //check this required this.foodService, required this.size
  }) : super(key: key);

  @override
  State<ViewFoods> createState() => _ViewFoodsState();
}
//widget that retrieves a list of food items
//displays a list of food items with their names, prices, discounted prices, images
//add to cart button 
class _ViewFoodsState extends State<ViewFoods> {
  FoodService foodService = FoodService();
  late List<Food> foods;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<ListOfFood>(
        future: foodService.getFood(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
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
                      "Most Popular Products",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      ...foods.map((food) {
                        return Container(
                          margin: EdgeInsets.all(12.0),//10
                          height: size.height * 0.26,//size of boxes that food items are in 
                          width: size.width * 0.20,//20
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("${food.price}",
                                    style: TextStyle(color: Colors.red,
                                    decoration: TextDecoration.lineThrough)
                                  ),
                                  Text("${food.price_with_discount}"),
                                ],
                              ),
                                Image.memory(food.image_memory, 
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
                  ),///
                ],
              ),
            );
          }
          return Container(
              margin: EdgeInsets.all(20),
              height: size.height,
              width: double.infinity,
              color: Colors.white,
              child: CircularProgressIndicator()
            );
        });
  }
} //main


class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}