import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> screens ={
      
      'Dashboard': {
        'route': '/dashboard',
        'icon': const Icon(Icons.dashboard),
      },
      'Menu': {
        'route': '/menu',
        'icon': const Icon(Icons.menu_book),
      },
      'Opening Hours': {
        'route': '/opening-hours',
        'icon': const Icon(Icons.lock_clock),
      },
      'Logout': {
        'route': '/logout',
        'icon': const Icon(Icons.logout_outlined),
      },
      
    };
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 65.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary),
              child: Text(
                'Dinner Dash Backend',
                style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white),
              ),
            ),
          ),
          ...screens.entries.map((screen){
            return ListTile(
            leading: screen.value['icon'],
            title: Text(screen.key),
            onTap: () {
              Navigator.pushNamed(context, screen.value['routeName']);
            },
          );
          })
      ],
      ),
    );
  }
}


