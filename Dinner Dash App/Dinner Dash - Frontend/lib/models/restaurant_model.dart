import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/category_model.dart';
import 'package:flutter_app/models/opening_hours_model.dart';
import 'package:flutter_app/models/product_model.dart';


/*class Restaurant extends Equatable {
  
  final int id;
  final String imageUrl;
  final String name;
  final List<String> tags;
  final List<MenuItem> menuItems;
  final int deliveryTime;
  final String priceCategory;
  final double deliveryFee;
  final double distance;

  Restaurant({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.tags,
    required this.menuItems,
    required this.deliveryTime,
    required this.priceCategory,
    required this.deliveryFee,
    required this.distance,
  });

  @override
  List<Object?> get props => [id, imageUrl, name, tags, menuItems, deliveryTime, deliveryFee, distance];

  static List<Restaurant> restaurants = [
    Restaurant(
      id: 1,
      name: 'Dominos',
      imageUrl: 'assets/dominos.png',
        tags: MenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 1)
          .map((menuItem) => menuItem.category)
          .toSet()
          .toList(),
      menuItems: MenuItem.menuItems
        .where((menuItem) => menuItem.restaurantId == 1)
        .toList(),
      deliveryTime: 30,
      priceCategory: '\€\€',
      deliveryFee: 5.99,
      distance: 1.2,
    ),
    Restaurant(
      id: 2,
      name: 'Supermacs',
      imageUrl: 'assets/supermacs.png',
      tags: MenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 2)
          .map((menuItem) => menuItem.category)
          .toSet()
          .toList(),
      menuItems: MenuItem.menuItems
        .where((menuItem) => menuItem.restaurantId == 2)
        .toList(),
      deliveryTime: 30,
      priceCategory: '\€',
      deliveryFee: 5.99,
      distance: 1.2,
    ),
    Restaurant(
      id: 3,
      name: 'Elite Cakes',
      imageUrl: 'assets/elite-cakes.png',
      tags: MenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 3)
          .map((menuItem) => menuItem.category)
          .toSet()
          .toList(),
      menuItems: MenuItem.menuItems
        .where((menuItem) => menuItem.restaurantId == 3)
        .toList(),
      deliveryTime: 45,
      priceCategory: '\€',
      deliveryFee: 3.99,
      distance: 1.6,
    ),
    Restaurant(
      id: 4,
      name: 'Starbucks',
      imageUrl: 'assets/starbucks.png',
      tags: MenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 4)
          .map((menuItem) => menuItem.category)
          .toSet()
          .toList(),
      menuItems: MenuItem.menuItems
        .where((menuItem) => menuItem.restaurantId == 4)
        .toList(),
      deliveryTime: 15,
      priceCategory: '\€',
      deliveryFee: 2.99,
      distance: 2.5,
    ),
    Restaurant(
      id: 5,
      name: 'Chopped',
      imageUrl: 'assets/chopped.png',
      tags: MenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 5)
          .map((menuItem) => menuItem.category)
          .toSet()
          .toList(),
      menuItems: MenuItem.menuItems
        .where((menuItem) => menuItem.restaurantId == 5)
        .toList(),
      deliveryTime: 25,
      priceCategory: '\€',
      deliveryFee: 1.99,
      distance: 1.9,
    ),
  ];*/ ///original static list of restaurants

//}
//////////////////original////////////////////
/*class Restaurant extends Equatable {
  final String id;
  final String imageUrl;
  final String description;
  final String name;
  final List<String> tags;
  final List<Category> categories;
  final List<Product> products;
  final List<OpeningHours> openingHours;
  final int deliveryTime;
  final String priceCategory;
  final double deliveryFee;
  final double distance;

  Restaurant({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.categories,
    required this.tags,
    required this.products,
    required this.openingHours,
    this.deliveryTime = 10,
    this.priceCategory = '\$',
    this.deliveryFee = 10,
    this.distance = 15,
  });

  import 'package:cloud_firestore/cloud_firestore.dart';

  

factory Restaurant.fromSnapshot(DocumentSnapshot snap) {
  return Restaurant(
    id: snap.id,
    name: snap.get('name'),
    imageUrl: snap.get('imageUrl'),
    description: snap.get('description'),
    tags: List<String>.from(snap.get('tags')),
    categories: List<Map<String, dynamic>>.from(snap.get('categories'))
        .map((data) => Category.fromSnapshot(data))
        .toList(),
    products: List<Map<String, dynamic>>.from(snap.get('products'))
        .map((data) => Product.fromJson(data))
        .toList(),
    openingHours: List<Map<String, dynamic>>.from(snap.get('openingHours'))
        .map((data) => OpeningHours.fromSnapshot(data))
        .toList(),
    deliveryTime: snap.get('deliveryTime') ?? 10,
    priceCategory: snap.get('priceCategory') ?? '\$',
    deliveryFee: snap.get('deliveryFee') ?? 10.0,
    distance: snap.get('distance') ?? 15.0,
  );
}



  @override
  List<Object> get props {
    return [
      id,
      description,
      categories,
      imageUrl,
      name,
      tags,
      products,
      openingHours,
      deliveryTime,
      deliveryFee,
      distance
    ];
  }

  static List<Restaurant> restaurants = [];
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant extends Equatable {
  final String id;
  final String imageUrl;
  final String description;
  final String name;
  final List<String> tags;
  final List<Category> categories;
  final List<Product> products;
  final List<OpeningHours> openingHours;
  final int deliveryTime;
  final String priceCategory;
  final double deliveryFee;
  final double distance;

  Restaurant({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.categories,
    required this.tags,
    required this.products,
    required this.openingHours,
    this.deliveryTime = 10,
    this.priceCategory = '\$',
    this.deliveryFee = 10,
    this.distance = 15,
  });

  /*factory Restaurant.fromSnapshot(DocumentSnapshot snap) {
    return Restaurant(
      id: snap.id,
      name: snap.get('name'),
      imageUrl: snap.get('imageUrl'),
      description: snap.get('description'),
      tags: List<String>.from(snap.get('tags')),
      categories: List<Map<String, dynamic>>.from(snap.get('categories'))
          .map((data) => Category.fromSnapshot(data))
          .toList(),
      products: List<Map<String, dynamic>>.from(snap.get('products'))
          .map((data) => Product.fromJson(data))
          .toList(),
      openingHours: List<Map<String, dynamic>>.from(snap.get('openingHours'))
          .map((data) => OpeningHours.fromSnapshot(data))
          .toList(),
      deliveryTime: snap.get('deliveryTime') ?? 10,
      priceCategory: snap.get('priceCategory') ?? '\$',
      deliveryFee: snap.get('deliveryFee') ?? 10.0,
      distance: snap.get('distance') ?? 15.0,
    );
  }//original 
  factory Restaurant.fromSnapshot(DocumentSnapshot snap) {
  var snapData = snap.data() as Map<String, dynamic>;
  
  return Restaurant(
    id: snap.id,
    name: snapData.containsKey('name') ? snapData['name'] : 'Unknown',
    imageUrl: snapData.containsKey('imageUrl') ? snapData['imageUrl'] : 'default_image_url_here',
    description: snapData.containsKey('description') ? snapData['description'] : 'No description available',
    tags: snapData.containsKey('tags') ? List<String>.from(snapData['tags']) : [],
    categories: snapData.containsKey('categories') ? 
      List<Map<String, dynamic>>.from(snapData['categories'])
          .map((data) => Category.fromSnapshot(data))
          .toList() : [],
    products: snapData.containsKey('products') ? 
      List<Map<String, dynamic>>.from(snapData['products'])
          .map((data) => Product.fromJson(data))
          .toList() : [],
    openingHours: snapData.containsKey('openingHours') ? 
      List<Map<String, dynamic>>.from(snapData['openingHours'])
          .map((data) => OpeningHours.fromSnapshot(data))
          .toList() : [],
    deliveryTime: snapData.containsKey('deliveryTime') ? snapData['deliveryTime'] : 10,
    priceCategory: snapData.containsKey('priceCategory') ? snapData['priceCategory'] : '\$',
    deliveryFee: snapData.containsKey('deliveryFee') ? snapData['deliveryFee'] : 10.0,
    distance: snapData.containsKey('distance') ? snapData['distance'] : 15.0,
  );
}
*/
factory Restaurant.fromSnapshot(DocumentSnapshot snap) {
  var snapData = snap.data() as Map<String, dynamic>? ?? {};

  return Restaurant(
    id: snap.id,
    name: snapData['name'] as String? ?? 'Unknown',
    imageUrl: snapData['imageUrl'] as String? ?? 'assets/default.png', // Default image asset path
    description: snapData['description'] as String? ?? 'No description available',
    tags: List<String>.from(snapData['tags'] as List<dynamic>? ?? []),
    categories: (snapData['categories'] as List<dynamic>? ?? [])
        .map((data) => Category.fromSnapshot(data as Map<String, dynamic>))
        .toList(),
    products: (snapData['products'] as List<dynamic>? ?? [])
        .map((data) => Product.fromJson(data as Map<String, dynamic>))
        .toList(),
    openingHours: (snapData['openingHours'] as List<dynamic>? ?? [])
        .map((data) => OpeningHours.fromSnapshot(data as Map<String, dynamic>))
        .toList(),
    deliveryTime: snapData['deliveryTime'] as int? ?? 10,
    priceCategory: snapData['priceCategory'] as String? ?? '\$',
    deliveryFee: snapData['deliveryFee'] as double? ?? 10.0,
    distance: snapData['distance'] as double? ?? 15.0,
  );
}


  @override
  List<Object> get props {
    return [
      id,
      description,
      categories,
      imageUrl,
      name,
      tags,
      products,
      openingHours,
      deliveryTime,
      deliveryFee,
      distance
    ];
  }

  static List<Restaurant> restaurants = [];
}
