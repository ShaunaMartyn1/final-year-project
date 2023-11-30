class Restaurantlist{
  List<Restaurant> restaurants;
  Restaurantlist({required this.restaurants});

  factory Restaurantlist.fromList(List list){
    List<Restaurant> _restaurants = [];
    for  (var element in list){
      _restaurants.add(Restaurant.fromMap(element));
    }
    return Restaurantlist(restaurants: _restaurants);
  }
}


class Restaurant{
  String name;
  Restaurant({required this.name});
  factory Restaurant.fromMap(map){
    return Restaurant(name: map['name']);
  }
}