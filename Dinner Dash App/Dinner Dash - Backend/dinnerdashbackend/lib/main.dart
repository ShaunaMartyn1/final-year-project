import 'package:dinnerdashbackend/blocs/category/category_bloc.dart';
import 'package:dinnerdashbackend/blocs/product/product_bloc.dart';
import 'package:dinnerdashbackend/blocs/settings/settings_bloc.dart';
import 'package:dinnerdashbackend/firebase_options.dart';
import 'package:dinnerdashbackend/models/category_model.dart';
import 'package:dinnerdashbackend/models/product_model.dart';
import 'package:dinnerdashbackend/repos/restaurant/restaurant_repo.dart';
import 'package:dinnerdashbackend/screens/menu/menu_screen.dart';
import 'package:dinnerdashbackend/screens/settings/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RestaurantRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CategoryBloc()
              ..add(
                LoadCategories(categories: Category.categories),
              ),
          ),
          BlocProvider(
            create: (context) => ProductBloc(
                categoryBloc: BlocProvider.of<CategoryBloc>(context),
                restaurantRepo: context.read<RestaurantRepo>(),
              )..add(
                LoadProducts(products: Product.products),
              ),
          ),
          BlocProvider(
            create: (context) => SettingsBloc(
              restaurantRepo: context.read<RestaurantRepo>())
              ..add(
                const LoadSettings(),
              ),
          )
        ],
        child: MaterialApp(
          title: 'Food Delivery App Backend ',
          theme: ThemeData(),
          initialRoute: '/menu',
          routes: {
            '/menu': (context) => const MenuScreen(),
            '/settings': (context) => const SettingsScreen(),
          },
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
