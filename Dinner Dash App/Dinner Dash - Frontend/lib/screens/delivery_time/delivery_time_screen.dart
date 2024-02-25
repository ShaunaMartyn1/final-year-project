import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/basket/basket_bloc.dart';
import 'package:flutter_app/models/delivery_time_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryTimeScreen extends StatelessWidget {
  static const String routeName = '/delivery-time';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => DeliveryTimeScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Delivery Time')),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Text('Select'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Choose a Date',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        //popup message
                        SnackBar(
                          content: Text('Delivery Today'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text('Today'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        //popup message
                        SnackBar(
                          content: Text('Delivery Tomorrow'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text('Tomorrow'),
                  ),
                ],
              ),
            ),
            Text(
              'Choose the Time',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 2.5),
                  itemCount: DeliveryTime.deliveryTimes
                      .length, //item cards in the grid as delivery time options
                  itemBuilder: (context, index) {
                    return BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        return Card(
                          child: TextButton(
                            onPressed: () {
                              context.read<BasketBloc>()
                              .add(
                                SelectDeliveryTime(
                                  DeliveryTime.deliveryTimes[index]));
                            },
                            child: Text(
                              '${DeliveryTime.deliveryTimes[index].value}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
