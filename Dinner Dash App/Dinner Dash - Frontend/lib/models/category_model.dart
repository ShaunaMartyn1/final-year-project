import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/*class Category extends Equatable{

  final String id;
  final String name;
  final Image image;


  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, image];

  static List<Category> categories = [
    Category(
      id: 1.toString(),
      name: 'Pizza',
      image: Image.asset('assets/pizza.png'),
    ),
    
    Category(
      id: 2.toString(),
      name: 'Burger',
      image: Image.asset('assets/hamburger.png'),
    ),
  
  
    Category(
      id: 3.toString(),
      name: 'Salad',
      image: Image.asset('assets/salad.png'),
    ),
    
    Category(
      id: 4.toString(),
      name: 'Dessert',
      image: Image.asset('assets/sweets.png'),
    ),
    
    Category(
      id: 5.toString(),
      name: 'Drinks',
      image: Image.asset('assets/soft-drink.png'),
    ),
  ];
} original
*/

//same as in backend code
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int index;
  
  
  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.index,
  });

  Category copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    int? index,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      index: index ?? this.index,
    );
  }

 
  factory Category.fromSnapshot(Map<String, dynamic> snap) {
    return Category(
      id: snap['id'].toString(),
      name: snap['name'],
      description: snap['description'],
      imageUrl: snap['imageUrl'],
      index: snap['index'],
    );
  }

  @override
  List<Object> get props => [id, name, description, imageUrl, index];

  static List<Category> categories = const [
      Category(
        id: '1',
        name: 'Salads',
        description: 'Fresh and healthy',
        imageUrl: 'assets/salad.png',
        index: 0
    ),
    Category(
        id: '2',
        name: 'Desserts',
        description: 'Delicious and filling',
        imageUrl: 'assets/sweets.png',
        index: 1
    ),
    Category(
        id: '3',
        name: 'Drinks',
        description: 'Refreshing and tasty',
        imageUrl: 'assets/soft-drink.png',
        index: 2
    ),
    Category(
        id: '4',
        name: 'Pizza',
        description: 'Take a slice',
        imageUrl: 'assets/pizza.png',
        index: 3
    ),
  ];
}