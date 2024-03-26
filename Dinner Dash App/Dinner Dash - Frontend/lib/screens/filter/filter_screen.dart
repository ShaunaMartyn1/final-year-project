import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/filters/filters_bloc.dart';
import 'package:flutter_app/models/restaurant_model.dart';
import 'package:flutter_app/widgets/custom_category_filter.dart';
import 'package:flutter_app/widgets/custom_price_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterScreen extends StatelessWidget {
  static const String routeName = '/filters';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => FilterScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filter')),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<FiltersBloc, FiltersState>(
                builder: (context, state) {
                  if (state is FiltersLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FiltersLoaded) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(),
                      ),
                      child: Text('Apply'),
                      onPressed: () {
                        /*var categories = state.filter.categoryFilters
                            .where((filter) => filter.value)
                            .map((filter) => filter.category.name)
                            .toList();

                        var prices = state.filter.priceFilters
                            .where((filter) => filter.value)
                            .map((filter) => filter.price.price)
                            .toList();

                        List<Restaurant> restaurants = Restaurant.restaurants
                            .where(
                              (restaurant) => categories.any(
                                (category) =>
                                    restaurant.tags.contains(category),
                              ),
                            )
                            .where(
                              (restaurant) => prices.any(
                                (price) =>
                                    restaurant.priceCategory.contains(price),
                              ),
                            )
                            .toList();*/

                        Navigator.pushNamed(context, '/restaurant-listing',
                            arguments: state.filteredRestaurants);
                      },
                    );
                  } else {
                    return Text('Error');
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // alignns to left
          children: [
            Text(
              'Price',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            CustomPriceFilter(),
            Text(
              'Category',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            CustomCategoryFilter(),
          ],
        ),
      ),
    );
  }
}
//MOVED TO CUSTOM_CATEGORY_FILTER.DART

/*class CustomCategoryFilter extends StatelessWidget {
  final List<Category> categories;
  const CustomCategoryFilter({
    Key? key,
    required this.categories
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index){
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(
              categories[index].name,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.black),
            ),
            SizedBox(
              height: 25,
              child: Checkbox(
                value: false,
              onChanged: (bool? newValue){},
            ),
          ),
          ],
          ),
        );
      });
  }
}*/

//MOVED TO CUSTOME_PRICE_FILTER.DART

/*class CustomPriceFilter extends StatelessWidget {
  final List<Price> prices;
  const CustomPriceFilter({
    Key? key,
    required this.prices
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: prices
      .map((price) =>
        InkWell(
          onTap: (){},
          child: Container(
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 10
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              price.price,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.black, fontSize: 20, ),
            ),
              ),
        ),
      )
      .toList(),
    );
  }
}*/