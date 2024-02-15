import 'package:flutter/material.dart';

class BasketScreen extends StatelessWidget{
static const String routeName = '/basket';
  
  
  static Route route(){
      return MaterialPageRoute(
        builder: (_) => BasketScreen(),
        settings: RouteSettings(name: routeName)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Basket'), actions: [
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.edit),
          )],),
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
            onPressed: (){
            },
            child: Text('Checkout'),
          ),
        ],
        ),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cutlery',
              style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Theme.of(context).colorScheme.secondary)
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 30),
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
                SizedBox(
                  width: 100,
                  child: SwitchListTile(
                    dense: false,
                    value: false,
                    onChanged: (bool? newValue) {},
                    )
                  )
                ]
              ),
            ),
            Text(
              'Items',
              style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Theme.of(context).colorScheme.secondary)
            ),
            ListView.builder(
              shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '1x',
                          style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Theme.of(context).colorScheme.secondary),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          'Pizza Margherita',
                                      style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    Text(
                      '\€ 5.00',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ]
                  ),
                );
              },),
              Container(
                width: double.infinity,
                height: 100,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Image.asset('assets/delivery.png'),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text('Delivery is 20 mins away',
                            style: Theme.of(context).textTheme.headlineSmall, ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Change',
                                  style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Theme.of(context).colorScheme.secondary),
                            ),
                          )
                      ],)
                    ]),),
                Container(
                  width: double.infinity,
                  height: 100,
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 20),
                              Text('Add voucher code',
                                style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Apply',
                                      style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: Theme.of(context).colorScheme.secondary),
                                ),
                              )
                          ],
                        ),
                    Image.asset('assets/voucher.png'),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      '\€ 20.00',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                ],
              ),
              SizedBox(height: 5), 
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Fee',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      '\€ 5.00',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      '\€ 25.00',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                ],
              ),
            ],
            ),
          ),
        ],
        ),
      )
    );
  }
}