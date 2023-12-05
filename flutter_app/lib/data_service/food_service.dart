// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FoodService {
  Future<ListOfFood> getFood() async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:8000/food/foodlist"));

    print(jsonDecode(response.body));
    return ListOfFood.fromJson(jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
    
  }
  //Search for products 
  Future<ListOfFood> getFoodBySearch(String keyword) async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:8000/food/search/$keyword"));//Check this 

    print(jsonDecode(response.body));
    return ListOfFood.fromJson(jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
    
  }

   //Search for categories
  Future<ListOfFood> getFoodByCategory(String categoryName) async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:8000/food/category/$categoryName")); 

    print(jsonDecode(response.body));
    return ListOfFood.fromJson(jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
    
  }

   //Search for restaurant
  Future<ListOfFood> getFoodByRestaurant(String restaurantName) async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:8000/food/restaurant/$restaurantName")); 

    print(jsonDecode(response.body));
    return ListOfFood.fromJson(jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
    
  }

  Future<CategoryList> getCategory()async{
    var response =
        await http.get(Uri.parse("http://127.0.0.1:8000/food/categorylist"));
        return CategoryList.fromList(
          jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
  }
  
  Future<RestaurantList> getRestaurant()async{
    var response =
        await http.get(Uri.parse("http://127.0.0.1:8000/food/restaurantlist"));//restaurantList thats why it didnt work
        return RestaurantList.fromList(
          jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
  }
  
}

class CategoryList{
  List<Category> categories;
  CategoryList({required this.categories});

  factory CategoryList.fromList(List list){
    List<Category> _categories = [];
    for  (var element in list){
      _categories.add(Category.fromMap(element));
    }
    //return CategoryList(categories: []);This is why it wasnt showing categories
        return CategoryList(categories: _categories);

  }
}

class Category{
  String name;
  Category({required this.name});
  factory Category.fromMap(map){
    return Category(name: map['name']);
  }
}

class RestaurantList{
  List<Restaurant> restaurants;
  RestaurantList({required this.restaurants});

  factory RestaurantList.fromList(List list){
    List<Restaurant> _restaurants = [];
    for  (var element in list){
      _restaurants.add(Restaurant.fromMap(element));
    }
    return RestaurantList(restaurants: _restaurants);
  }
}


class Restaurant{
  String name;
  Restaurant({required this.name});
  factory Restaurant.fromMap(map){
    return Restaurant(name: map['name']);
  }
}
/*class ListOfFood {
  List<Food> foods;
  ListOfFood({required this.foods});
  factory ListOfFood.fromList(List list) {
   
    List<Food> _foods = [];
    for (var element in list) {
      _foods.add(Food.fromJson(element));
    }
    return ListOfFood(foods: _foods);
  } 
}*///old giving error???

//new
class ListOfFood {
  late List<Food> foods;

  ListOfFood({required List<Food> foods}) {
    this.foods = foods;
  }

  factory ListOfFood.fromJson(List<dynamic> list) {
    List<Food> _foods = [];
    for (var element in list) {
      _foods.add(Food.fromJson(element));
    }
    return ListOfFood(foods: _foods);
  }
}
///new end



class Food {
  int id;
  String name;
  int price;
  int discount;
  double price_with_discount;
  String restaurant;
  String category;
  String image;
  String preview;
  Uint8List image_memory;
  Food({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.restaurant,
    required this.category,
    required this.image,
    required this.preview,
    required this.image_memory,
    required this.price_with_discount,
  });

  factory Food.fromJson(map) {
    return Food(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      discount: map['discount'],
      restaurant: map['restaurant'],
      category: map['category'],
      image: map['image'],
      preview: map['preview'],
      image_memory: base64Decode(map['image_memory']),
      price_with_discount: map['price_with_discount'],
    );
  }
}
