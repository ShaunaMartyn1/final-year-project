import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/basket/basket_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/voucher_model.dart';

class VoucherScreen extends StatelessWidget {
  static const String routeName = '/voucher';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => VoucherScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Voucher')),
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
                child: Text('Apply Voucher'),
                onPressed: () {},
              )
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
              'Enter Voucher Code:',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter your voucher code here',
                        contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Your Vouchers',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            ListView.builder(
              itemCount: Voucher.vouchers.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1x',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: Theme.of(context).colorScheme.secondary),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          Voucher.vouchers[index].code,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      BlocBuilder<BasketBloc, BasketState>(
                        builder: (context, state) {
                          return TextButton(
                            onPressed: () {
                              context
                                .read<BasketBloc>()
                                .add(AddVoucher(Voucher.vouchers[index]));
                              Navigator.pop(context);
                            },
                            child: Text('Apply'),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
