import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/basket/basket_bloc.dart';

/*class EditBasketScreen extends StatelessWidget {
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
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .secondary, // 'primary' is deprecated and replaced with 'backgroundColor'
                  shape: RoundedRectangleBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 50),
                ),
                
                child: Text('Done'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Added to enable scrolling when content exceeds screen size
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              // Items Section
              Text(
                'Items',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              BlocBuilder<BasketBloc, BasketState>(
                builder: (context, state) {
                  if (state is BasketLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is BasketLoaded) {
                    if (state.basket.items.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: Text('Basket is empty')),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap:
                            true, // Important to prevent infinite height error
                        physics:
                            NeverScrollableScrollPhysics(), // Disables scrolling within ListView
                        itemCount: state.basket.items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.basket.items[index].name),
                            trailing: Text(
                                '€${state.basket.items[index].price.toString()}'),
                                
                          );
                        },
                        
                      );
                    }
                  } else {
                    return Text('Error');
                  }
                },
              ),
              
              // Summary Section
              _summarySection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summarySection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: BlocBuilder<BasketBloc, BasketState>(
        builder: (context, state) {
          if (state is BasketLoading){
            return Center(child: CircularProgressIndicator()
            );
          }
          if (state is BasketLoaded) {
            return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal',
                      style: Theme.of(context).textTheme.headlineSmall!),
                  Text('\€${state.basket.subtotalString}',
                      style: Theme.of(context).textTheme.headlineSmall!),
                ],
              ),
              SizedBox(height: 10),

              
              
            ],
          );

          }
          else {
            return Text('Error');
          }
          
        },
      ),
    );
  }
}*/

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
                'Items',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              BlocBuilder<BasketBloc, BasketState>(
                builder: (context, state) {
                  if (state is BasketLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is BasketLoaded) {
                    if (state.basket.items.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: Text('Basket is empty')),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.basket.items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.basket.items[index].name),
                            trailing: Wrap(
                              spacing: 12, // space between two icons
                              children: <Widget>[
                                Text('€${state.basket.items[index].price.toString()}'), // Item price
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Dispatch an event to remove the item from the basket
                                    context.read<BasketBloc>().add(RemoveItem(state.basket.items[index]));
                                  },
                                ),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: (){
                                    context.read<BasketBloc>()
                                    ..add(AddItem(state.basket
                                      .itemQuantity(state.basket.items)
                                      .keys
                                      .elementAt(index)));
                                  },
                                  icon: Icon(Icons.add_circle),
                                ),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () {
                                    context.read<BasketBloc>()
                                    ..add(RemoveItem(state.basket
                                      .itemQuantity(state.basket.items)
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

