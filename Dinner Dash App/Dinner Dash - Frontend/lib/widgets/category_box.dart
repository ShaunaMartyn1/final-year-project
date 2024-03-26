import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/restaurant/restaurant_bloc.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBox extends StatelessWidget {
  final Category category;
  
  const CategoryBox({
    Key? key,
    required this.category
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*final List<Restaurant> restaurants = Restaurant.restaurants
      .where((restaurant) => restaurant.tags.contains(category.name),)
      .toList();*/// Importing static list old way without db
      List<Restaurant> restaurants = context.select((RestaurantBloc bloc) {
        if (bloc.state is RestaurantLoaded){
          return (bloc.state as RestaurantLoaded).restaurants;
        } else{
          return <Restaurant>[];
        }
      });

      final List<Restaurant> filteredRestaurants = restaurants
        .where((restaurant) => restaurant.categories.contains(category))
        .toList();

    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/restaurant-listing',
          arguments: filteredRestaurants,
        );
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                //child: category.image, - dont need anymore
              ),
            ),
            Positioned(
              top: 5, 
              left: 7.5,
              child: Image.asset(category.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  category.name,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            )
        ],),
      ),
    );
  }
}


