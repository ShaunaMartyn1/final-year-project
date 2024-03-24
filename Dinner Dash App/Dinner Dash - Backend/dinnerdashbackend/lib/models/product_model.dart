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

  factory Product.fromSnapshot(Map<String, dynamic> snap) {
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
      imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8U3BhZ2hldHRpJTIwQm9sb2duZXNlfGVufDB8fDB8fHww',
      price: 12.99,
    ),
    Product(
      id: '2',
      restaurantId: 'LyXqruY9ud3ni3RtzJzf',
      name: 'Margherita Pizza',
      category: 'Pizza',
      description: 'Tomato, mozzarella, and basil',
      imageUrl: 'https://images.unsplash.com/photo-1595854341625-f33ee10dbf94?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8TWFyZ2hlcml0YSUyMFBpenphfGVufDB8fDB8fHww',
      price: 9.99,
    ),
    Product(
      id: '3',
      restaurantId: 'LyXqruY9ud3ni3RtzJzf',
      name: 'Tiramisu',
      category: 'Dessert',
      description: 'Coffee-flavoured Italian dessert',
      imageUrl: 'https://images.unsplash.com/photo-1568627175730-73d05bd69ca9?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dGlyYW1pc3V8ZW58MHx8MHx8fDA%3D',
      price: 6.99,
    ),
    Product(
      id: '4',
      restaurantId: 'LyXqruY9ud3ni3RtzJzf',
      name: 'Bruschetta',
      category: 'Pizza',
      description: 'Grilled bread rubbed with garlic and topped with tomatoes, olive oil, salt, and pepper',
      //imageUrl: 'assets/bruschetta.jpg',
      imageUrl: 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      price: 5.99,
    ),
  ];
}