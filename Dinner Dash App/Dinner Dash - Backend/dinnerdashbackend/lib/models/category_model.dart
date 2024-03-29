
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

  // Convert the Category object to a map
  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'index': index,
    };
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