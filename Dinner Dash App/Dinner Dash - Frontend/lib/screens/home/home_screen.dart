import 'package:flutter/material.dart';
import 'package:flutter_app/models/category_model.dart';
import 'package:flutter_app/models/restaurant_model.dart';
import 'package:flutter_app/widgets/category_box.dart';
import 'package:flutter_app/widgets/food_search_box.dart';
import 'package:flutter_app/widgets/promo_box.dart';

import '../../models/promo_model.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';//home

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => HomeScreen(),
        settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: Category.categories.length,
                    itemBuilder: (context, index){
                      return CategoryBox(category: Category.categories[index]);
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 125,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: Promo.promos.length,//promos lenght 
                    itemBuilder: (context, index){
                      return PromoBox(promo: Promo.promos[index]);
                  },
                ),
                ),
              ),
              FoodSearchBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Popular Restaurants',
                    style: Theme.of(context).textTheme.headlineMedium,),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: Restaurant.restaurants.length,
                itemBuilder: (context, index){
                  return RestaurantCard(restaurant: Restaurant.restaurants[index]);
                })
            ],
          ),
        )
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard({
    Key? key,
    required this.restaurant,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children:[ Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  //image: NetworkImage(restaurant.imageUrl),
                  image: AssetImage('assets/dominos.png'),
                  fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0,)
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${restaurant.deliveryTime} min ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(restaurant.name,
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 5),
              //Text('${restaurant.tags}'),
              Row(
                children: restaurant.tags
                  .map(
                    (tag) => restaurant.tags.indexOf(tag) ==
                                restaurant.tags.length -1
                        ? Text(tag,
                            style: Theme.of(context).textTheme.bodySmall)
          
                        : Text('$tag,',
                            style: Theme.of(context).textTheme.bodySmall),
                        )
                        .toList()),
                SizedBox(height: 5),
              Text('${restaurant.distance}km - \€${restaurant.deliveryFee} delivery fee'),
            ],),
          )
        ],
      ),
    );
  }
}



//class CustomAppBar extends StatelessWidget with PreferredSizeWidget { - Error on PreferredSizeWidget
  class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
      icon: Icon(Icons.person),
      onPressed: (){},
    ),
    centerTitle: false,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current Location:',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white
              ),
        ),
        Text('123 Eyre Square, Galway',style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white
              ),
        ),
      ],
    ));
  }
  
  @override
  Size get preferredSize => Size.fromHeight(56.0);// standard flutter size for appbar
}
