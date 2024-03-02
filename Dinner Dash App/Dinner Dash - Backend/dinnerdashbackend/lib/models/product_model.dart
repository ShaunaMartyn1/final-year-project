import 'package:equatable/equatable.dart';

class Product extends Equatable {
  
  final String? id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final double price;
  
  
  const Product({
    this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  Product copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    double? price,
   
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
    );
  }

  @override
  List<Object> get props => [id!, name, price, description, imageUrl, category];//check id 

  static List<Product> products = const [
    Product(
      id: '1',
      name: 'Spaghetti Bolognese',
      category: 'Italian',
      description: 'Spaghetti with a rich tomato and meat sauce',
      imageUrl: 'assets/spaghettibolognese.jpg',
      price: 12.99,
    ),
    Product(
      id: '2',
      name: 'Margherita Pizza',
      category: 'Pizza',
      description: 'Tomato, mozzarella, and basil',
      imageUrl: 'assets/MargheritaPizza.jpg',
      price: 9.99,
    ),
    Product(
      id: '3',
      name: 'Tiramisu',
      category: 'Dessert',
      description: 'Coffee-flavoured Italian dessert',
      imageUrl: 'assets/tiramisu.jpg',
      price: 6.99,
    ),
    Product(
      id: '4',
      name: 'Bruschetta',
      category: 'Pizza',
      description: 'Grilled bread rubbed with garlic and topped with tomatoes, olive oil, salt, and pepper',
      imageUrl: 'assets/bruschetta.jpg',
      price: 5.99,
    ),
  ];
}