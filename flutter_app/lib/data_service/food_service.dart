import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodService {
  Future<ListOfFood> getFood() async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:8000/food/foodlist"));

    print(jsonDecode(response.body));
    return ListOfFood.fromList(
        jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
  }
}

class ListOfFood {
  List<Food> foods;
  ListOfFood({required this.foods});
  factory ListOfFood.fromJson(List list) {
    List<Food> _foods = [];
    for (var element in list) {
      _foods.add(Food.fromJson(element));
    }
    return ListOfFood(foods: _foods);
  }
  
}

class Food {
  int id;
  String name;
  int price;
  int discount;
  String restaurant;
  String category;
  String image;
  String preview;
  Food({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.restaurant,
    required this.category,
    required this.image,
    required this.preview,
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
    );
  }
}
