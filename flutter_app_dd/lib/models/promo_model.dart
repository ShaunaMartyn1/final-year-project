import 'package:equatable/equatable.dart';

class Promo extends Equatable{
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  Promo({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props =>  [
      id,
      title,
      description,
      imageUrl,
  ];

  static List<Promo> promos = [
    Promo(
      id: 1,
      title: 'FREE Delivery on Your First Order',
      description: 'Place an order for \€10 or more and your delivery is free ',
      imageUrl:  ('assets/food.jpg')
    ),
    Promo(
      id: 2,
      title: 'Use Code: DINNERDASH for 10% off your order',
      description: 'Use promocode DINNERDASH to get 10% off any order',
      imageUrl:   ('assets/10gpt.webp')//change this later to a better image
    )
  ];
}