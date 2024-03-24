import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/basket/basket_bloc.dart';


class EditBasketScreen extends StatelessWidget {
  static const String routeName = '/edit-basket';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => EditBasketScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Basket'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 50),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('Done'),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'products',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              BlocBuilder<BasketBloc, BasketState>(
                builder: (context, state) {
                  if (state is BasketLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is BasketLoaded) {
                    if (state.basket.products.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: Text('Basket is empty')),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.basket.products.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.basket.products[index].name),
                            trailing: Wrap(
                              spacing: 12, // space between two icons
                              children: <Widget>[
                                Text('€${state.basket.products[index].price.toString()}'), // Item price
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Dispatch an event to remove the item from the basket
                                    context.read<BasketBloc>().add(RemoveProduct(state.basket.products[index]));
                                  },
                                ),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: (){
                                    context.read<BasketBloc>()
                                    ..add(AddProduct(state.basket
                                      .itemQuantity(state.basket.products)
                                      .keys
                                      .elementAt(index)));
                                  },
                                  icon: Icon(Icons.add_circle),
                                ),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () {
                                    context.read<BasketBloc>()
                                    ..add(RemoveProduct(state.basket
                                      .itemQuantity(state.basket.products)
                                      .keys
                                      .elementAt(index)));
                                  },
                                  icon: Icon(Icons.remove_circle),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    return Text('Error');
                  }
                },
              ),
              //_summarySection(context),
            ],
          ),
        ),
      ),
    );
  }

}

