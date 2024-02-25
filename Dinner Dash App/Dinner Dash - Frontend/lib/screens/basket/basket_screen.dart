import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/basket/basket_bloc.dart';

class BasketScreen extends StatelessWidget {
  static const String routeName = '/basket';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BasketScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basket'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/edit-basket');
            },
            icon: Icon(Icons.edit),
          ),
        ],
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
                onPressed: () {},
                child: Text('Checkout'),
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
              Text(
                'Cutlery',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Do you need cutlery?',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        if (state is BasketLoading) {
                          return CircularProgressIndicator();
                        } else if (state is BasketLoaded) {
                          return Switch(
                            value: state.basket.cutlery,
                            onChanged: (bool newValue) {
                              context.read<BasketBloc>().add(ToggleSwitch());
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
              // Delivery Information Section
              _deliveryInformation(context),
              // Voucher Code Section
              _voucherCodeSection(context),
              // Summary Section
              _summarySection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _deliveryInformation(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/delivery.png',
              width: 50), // Make sure this asset is available in your project
          Expanded(
            child: BlocBuilder<BasketBloc, BasketState>(
              builder: (context, state) {
                if (state is BasketLoaded){
                  return
                  (state.basket.deliveryTime == null) ? //check if delivery time is null
                  
                   Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delivery in 20 mins',
                        style: Theme.of(context).textTheme.headlineSmall),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/delivery-time');
                      },
                      child: Text('Change',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary)),
                    ),
                  ],
                )
                  : Text('Delivery at ${state.basket.deliveryTime!.value}',
                      style: Theme.of(context).textTheme.headlineSmall);
                }
                else {
                  return Text('Error');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _voucherCodeSection(BuildContext context) {
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
          if (state is BasketLoaded) {
            return (state.basket.voucher == null)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('Have a voucher?',
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/voucher');
                        },
                        child: Text(
                          'Apply',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ],
                  )
                : Text('Voucher Added',
                    style: Theme.of(context).textTheme.headlineSmall);
          } else {
            return Text('Error');
          }
        },
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
          if (state is BasketLoading) {
            return Center(child: CircularProgressIndicator());
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Fee',
                        style: Theme.of(context).textTheme.headlineSmall!),
                    Text('\€3.99',
                        style: Theme.of(context).textTheme.headlineSmall!),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                    Text('\€${state.basket.totalString}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                  ],
                ),
              ],
            );
          } else {
            return Text('Error');
          }
        },
      ),
    );
  }
}
