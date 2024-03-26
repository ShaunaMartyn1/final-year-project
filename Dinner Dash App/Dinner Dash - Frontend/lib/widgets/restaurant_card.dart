
/*import 'package:flutter/material.dart';

import '../models/models.dart';
import 'widgets.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  
  const RestaurantCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {
        print(restaurant);//console log this to see if it works
        Navigator.pushNamed(
          context, '/restaurant-details',
          arguments: restaurant);
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(restaurant.imageUrl),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 60,
                  height: 30,
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${restaurant.deliveryTime} min',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 5),
                    //wrap the Row widget properly to display tags
                    RestaurantTags(restaurant: restaurant),
                    SizedBox(height: 5),
                    Text(
                      '${restaurant.distance} km away - \€${restaurant.deliveryFee} delivery fee',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import '../models/models.dart';  // Ensure this contains the Restaurant model.
import 'widgets.dart';  // Ensure this contains the RestaurantTags widget.

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Restaurant Card tapped");  // This will log the restaurant details to the console.
        // Navigate to the RestaurantDetailsScreen with the restaurant object.
        Navigator.pushNamed(
          context, 
          '/restaurant-details',
          arguments: restaurant,
        );
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(restaurant.imageUrl), // Make sure the image path is correct.
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 60,
                  height: 30,
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${restaurant.deliveryTime} min',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 5),
                    RestaurantTags(restaurant: restaurant), // Display restaurant tags.
                    SizedBox(height: 5),
                    Text(
                      '${restaurant.distance} km away - \€${restaurant.deliveryFee} delivery fee',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

