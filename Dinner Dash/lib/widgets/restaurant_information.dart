import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/widgets.dart';

import '../models/models.dart';

class RestaurantInformation extends StatelessWidget{
  
  final Restaurant restaurant;

  const RestaurantInformation({
    Key? key,
    required this.restaurant,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,//aligns the text to the left
        children: [
          Text(
            restaurant.name,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 10),
              RestaurantTags(restaurant:  restaurant),
              SizedBox(height: 5),
              Text(
                '${restaurant.distance} km away - \€${restaurant.deliveryFee} delivery fee',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            SizedBox(height: 10),
              Text(
                'Restaurant Information:',
                style: Theme.of(context).textTheme.headlineSmall!,
              ),
              SizedBox(height: 5),
              Text(
                'Dominos Galway East located in Prospect Hill, Galway',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 12,
                  color: Colors.black),
              ),
        ],
      ),
    );
  }

  
}