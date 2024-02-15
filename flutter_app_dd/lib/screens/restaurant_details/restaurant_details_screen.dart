import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant_model.dart';
import 'package:flutter_app/widgets/widgets.dart';

class RestaurantDetailsScreen extends StatelessWidget{
static const String routeName = '/restaurant-details';
  
  static Route route({required Restaurant restaurant}){
      return MaterialPageRoute(
        builder: (_) => RestaurantDetailsScreen (restaurant: restaurant),
        settings: RouteSettings(name: routeName)
    );
  }
  final Restaurant restaurant;
  const RestaurantDetailsScreen({
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    //Restaurant restaurant =  Restaurant.restaurants[0]; //CHECK THIS - Dont need only ready 1st restaurant
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(),
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
            ),
            onPressed: (){},
            child: Text('Basket'),
          ),
        ],
        ),
      ),
      ),
      extendBodyBehindAppBar: true,
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Container(
          height: 250,
          decoration: BoxDecoration(
            //puts a curve in the bottom of the image
            borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(
              MediaQuery.of(context).size.width, 50),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
                image:AssetImage('assets/dominos.png'),//change this later
                ),
              ),
            ),
            RestaurantInformation(restaurant: restaurant),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true ,
              physics: NeverScrollableScrollPhysics(),
              itemCount: restaurant.tags.length,
              itemBuilder: (context, index) {
                return _builderMenuItems(restaurant, context, index);
              },
            )
          ],
        ),
      )
    );
  }

  Widget _builderMenuItems(Restaurant restaurant, BuildContext context, int index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(restaurant.tags[index],
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).secondaryHeaderColor,
            fontSize: 25,),),
        ),
        Column(
          children: restaurant.menuItems
            .where((menuItem) => menuItem.category == restaurant.tags[index])
            .map(
              (menuItem) => Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20
                    ),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(menuItem.name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,),),
                      subtitle: Text(menuItem.description,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 12),),
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,//align buttons to the right to add
                        children: [
                        Text('\€${menuItem.price}', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          onPressed: () {},
                        )
                      ],),
                  ),
                  ),
                  Divider(
                    height: 2,),
                ],
              ),
            )
            .toList(),
        )
      ],
    );
  
  }

  

}