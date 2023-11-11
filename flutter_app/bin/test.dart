import 'dart:convert';

import 'package:http/http.dart' as http;

main() async {
  //ListOfFood listOfFood = await FoodService().getFood();
  //print(listOfFood.foods[0].name);
 
}

class FoodService {
 Future<ListOfFood> getFood() async {
   var response =
      await http.get(Uri.parse("http://127.0.0.1:8000/food/foodlist"));
  print(jsonDecode(response.body));
 // return ListOfFood.fromList(jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
   return ListOfFood.fromJson(jsonDecode(Utf8Decoder().convert(response.bodyBytes)));

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

previousmain() async {
  AuthService authService = AuthService();

  var response = await http.get(
      Uri.parse("http://127.0.0.1:8000/accounts/user/"),
      headers: {"Authorization": "adb4dcea3215539b3132c9a593406d72f18bed5e"});
  print(response.body);
}
//"key":"adb4dcea3215539b3132c9a593406d72f18bed5e"

/*RegistrationResponse? registrationResponse = await authService.registration(
      "shauna444", "november!", "november!", "shauna1@gmail.com");
  if (registrationResponse != null) {
    if (registrationResponse.email != null) {
      registrationResponse.email!.forEach((element) {
        print(element);
      });
    }

    if (registrationResponse.username != null) {
      registrationResponse.username!.forEach((element) {
        print(element);
      });
    }

    if (registrationResponse.non_field_errors != null) {
      registrationResponse.non_field_errors!.forEach((element) {
        print(element);
      });
    }

    if (registrationResponse.password1 != null) {
      registrationResponse.password1!.forEach((element) {
        print(element);
      });
    }

    if (registrationResponse.key != null) {
      print(registrationResponse.key!);
    }
  }
  LoginResponse? loginResponse = await authService.login("shauna12@gmail.com", "november!",);
  
  if(loginResponse != null) {
    if(loginResponse.key != null) print(loginResponse.key);
    if(loginResponse.non_field_errors != null)
      loginResponse.non_field_errors!.forEach((element){
        print(element);
      });
  }*/

class AuthService {
  final registrationUri = Uri.parse("http://127.0.0.1:8000/registration/");
  final loginUri = Uri.parse("http://127.0.0.1:8000/accounts/login/");
  final logoutUrl = Uri.parse("http://127.0.0.1:8000/accounts/logout/");

  Future<RegistrationResponse?> registration(
      String username, String password1, String password2, String email) async {
    var response = await http.post(registrationUri, body: {
      "username": username,
      "password1": password1,
      "password2": password2,
      "email": email,
    });
    //print(response.body);
    return RegistrationResponse.fromJson(jsonDecode(response.body));
  }

  Future<LoginResponse?> login(String usernameOremail, String password) async {
    var response = await http.post(loginUri, body: {
      "username": usernameOremail,
      "password": password,
    });
    print(response.body);
    return LoginResponse.fromJson(jsonDecode(response.body));
  }
}

class RegistrationResponse {
  List<dynamic>? non_field_errors;
  List<dynamic>? password1;
  List<dynamic>? username;
  List<dynamic>? email;
  dynamic key;

  RegistrationResponse({
    this.email,
    this.key,
    this.non_field_errors,
    this.password1,
    this.username,
  });

  factory RegistrationResponse.fromJson(mapOfBody) {
    return RegistrationResponse(
      email: mapOfBody["email"],
      key: mapOfBody["key"],
      non_field_errors: mapOfBody["non_field_errors"],
      password1: mapOfBody["password1"],
      username: mapOfBody["username"],
    );
  }
}

class LoginResponse {
  dynamic key;
  List<dynamic>? non_field_errors;
  LoginResponse({this.key, this.non_field_errors});

  factory LoginResponse.fromJson(mapOfBody) {
    return LoginResponse(
      key: mapOfBody['key'],
      non_field_errors: mapOfBody['non_field_errors'],
    );
  }
}
