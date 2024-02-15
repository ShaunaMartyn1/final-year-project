import 'package:flutter/material.dart';

class VoucherScreen extends StatelessWidget{
static const String routeName = '/voucher';
  
  static Route route(){
      return MaterialPageRoute(
        builder: (_) => VoucherScreen (),
        settings: RouteSettings(name: routeName)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VoucherScreen')),
      body: Center(
        child: ElevatedButton(
            child: Text('Home Screen'),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
      ),
    );
  }
}