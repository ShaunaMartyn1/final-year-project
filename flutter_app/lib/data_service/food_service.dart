// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
///import 'dart:core';///
// ignore: unused_import
//import 'dart:ffi';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class FoodService {
  Future<ListOfFood> getFood() async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:8000/food/foodlist"));

    print(jsonDecode(response.body));
    return ListOfFood.fromJson(jsonDecode(Utf8Decoder().convert(response.bodyBytes)));//original
    // return ListOfFood.fromList(jsonDecode(response.body));

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
}*/

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
