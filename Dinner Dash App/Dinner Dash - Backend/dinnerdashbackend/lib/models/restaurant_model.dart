import 'package:dinnerdashbackend/models/category_model.dart';
import 'package:dinnerdashbackend/models/models.dart';
import 'package:dinnerdashbackend/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Restaurant extends Equatable{
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? description;
  final List<String>? tags;
  final List<Category>? categories;
  final List <Product>? products;
  final List <OpeningHours>? openingHours;

  const Restaurant({
    this.id,
    this.name,
    this.imageUrl,
    this.description,
    this.tags,
    this.categories,
    this.products,
    this.openingHours,
  });
  
  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    description,
    tags,
    categories,
    products,
    openingHours
  ];

  Restaurant copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? description,
    List<String>? tags,
    List<Category>? categories,
    List<Product>? products,
    List<OpeningHours>? openingHours,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      openingHours: openingHours ?? this.openingHours,
    );
  }

  static List<Restaurant> restaurants = [
    Restaurant(
      id: '1',
      name: 'Supermacs',
      imageUrl: 'assets/supermacs.png',
      description: 'Tasty and Tempting Food',
      tags: const ['Burgers', 'Fries', 'Chicken', 'Salads', 'Desserts', 'Drinks', 'fast food'],
      categories: Category.categories,
      products: Product.products,
      openingHours: OpeningHours.openingHoursList,
    ),
    
  ];
}