import 'package:equatable/equatable.dart';

class Product extends Equatable {
  
  final String? id;
  final String? restaurantId;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final double price;
  
  
  const Product({
    this.id,
    this.restaurantId,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  Product copyWith({
    String? id,
    String? restaurantId,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    double? price,
   
  }) {
    return Product(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  factory Product.fromJson(Map<String, dynamic> snap) {
    return Product(
      id: snap['id'].toString(),
      restaurantId: snap['restaurantId'],
      name: snap['name'],
      category: snap['category'],
      description: snap['description'],
      imageUrl: snap['imageUrl'],
      price: snap['price'],
    );
  }

  @override
  List<Object> get props => [id!, restaurantId!,  name, price, description, imageUrl, category];//check id +restaurantId

  static List<Product> products = const [
    Product(
      id: '1',
      restaurantId: 'LyXqruY9ud3ni3RtzJzf',
      name: 'Spaghetti Bolognese',
      category: 'Italian',
      description: 'Spaghetti with a rich tomato and meat sauce',
      imageUrl: 'assets/spaghettibolognese.jpg',
      price: 12.99,
    ),
    Product(
      id: '2',
      restaurantId: 'LyXqruY9ud3ni3RtzJzf',
      name: 'Margherita Pizza',
      category: 'Pizza',
      description: 'Tomato, mozzarella, and basil',
      imageUrl: 'assets/MargheritaPizza.jpg',
      price: 9.99,
    ),
    Product(
      id: '3',
      restaurantId: 'LyXqruY9ud3ni3RtzJzf',
      name: 'Tiramisu',
      category: 'Dessert',
      description: 'Coffee-flavoured Italian dessert',
      imageUrl: 'assets/tiramisu.jpg',
      price: 6.99,
    ),
    Product(
      id: '4',
      restaurantId: 'LyXqruY9ud3ni3RtzJzf',
      name: 'Bruschetta',
      category: 'Pizza',
      description: 'Grilled bread rubbed with garlic and topped with tomatoes, olive oil, salt, and pepper',
      imageUrl: 'assets/bruschetta.jpg',
      price: 5.99,
    ),
  ];
}