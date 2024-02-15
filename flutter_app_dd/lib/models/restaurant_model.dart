

import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/menu_item_model.dart';

class Restaurant extends Equatable {
  
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
      imageUrl: 'assets/images/dominos.png',
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
      imageUrl: 'assets/images/supermacs.png',
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
      imageUrl: 'assets/images/elite-cakes.png',
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
      imageUrl: 'assets/images/starbucks.png',
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
      imageUrl: 'assets/images/chopped.png',
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
  ];
}
