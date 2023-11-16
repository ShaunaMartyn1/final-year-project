// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

 
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/data_service/food_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}); //check this

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Home extends StatefulWidget {
  const Home(); //changed thid took out super.key

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //taken from here 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFe6e6e6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        // ignore: prefer_const_constructors
        leading: InkWell(child: Icon(Icons.menu, color: Colors.black)),
        actions: [
          InkWell(
            child: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(),
              onPressed: () {},
              child: Text("Sign In", style: TextStyle()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: size.height * 0.1,
                width: double.infinity,
                child: TextField(
                  onChanged: (value) {
                    //do somehting with user input here
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    hintText: 'Search',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    suffixIcon: InkWell(
                        onTap: () {},
                        child: Material(
                          color: Colors.blue,
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(
                  color: Colors.black38,
                ),
              ),
              height: size.height * 0.1, //0.7
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 6), //6
                        padding: EdgeInsets.all(6.0), //6
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(8.0), //8
                        ),
                        child: Text("McDonalds"),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text("Supermacs"),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text("KFC"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, //space out categories
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {},
                  child: Text(
                    "Categories",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {},
                  child: Text(
                    "Restaurant",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
            ViewFoods(),
          ],
        ),
      ),
    );
  }
}

class ViewFoods extends StatefulWidget {
  const ViewFoods({
    Key? key, //check this required this.foodService, required this.size
  }) : super(key: key);

  @override
  State<ViewFoods> createState() => _ViewFoodsState();
}

class _ViewFoodsState extends State<ViewFoods> {
  FoodService foodService = FoodService();
  late List<Food> foods;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<ListOfFood>(
        future: foodService.getFood(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            List<Food> foods = snapshot.data!.foods;
            return Container(
              margin: EdgeInsets.all(20),
              height: size.height,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Most Popular Products",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      ...foods.map((food) {
                        return Container(
                          margin: EdgeInsets.all(12.0),//10
                          height: size.height * 0.26,//size of boxes that food items are in 
                          width: size.width * 0.20,//20
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text(
                                food.name, 
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("${food.price}",
                                    style: TextStyle(color: Colors.red,
                                    decoration: TextDecoration.lineThrough)
                                  ),
                                  Text("${food.price_with_discount}"),
                                ],
                              ),
                                Image.memory(food.image_memory, 
                                height: size.height * 0.11,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(),
                                  onPressed: () {},
                                  child: Text(
                                    "Add to Cart",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),///
                ],
              ),
            );
          }
          return Container(
              margin: EdgeInsets.all(20),
              height: size.height,
              width: double.infinity,
              color: Colors.white,
              child: CircularProgressIndicator()
            );
        });
  }
} //main

///CHECK THIS MIGHT DELETE
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

//////////////////////////////////////////////////////////////////////////////////////
/*
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/data_service/food_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}); //check this

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Home extends StatefulWidget {
  const Home(); //changed thid took out super.key

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FoodService foodService = FoodService();
  late List<Food> foods;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFe6e6e6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        // ignore: prefer_const_constructors
        leading: InkWell(child: Icon(Icons.menu, color: Colors.black)),
        actions: [
          InkWell(
            child: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(),
              onPressed: () {},
              child: Text("Sign In", style: TextStyle()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: size.height * 0.1,
                width: double.infinity,
                child: TextField(
                  onChanged: (value) {
                    //do something with user input here
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: Material(
                        color: Colors.blue,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, //space out categories
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {},
                  child: Text(
                    "Categories",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {},
                  child: Text(
                    "Restaurant",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
            FutureBuilder<ListOfFood>(
              future: foodService.getFood(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Food> foods = snapshot.data!.foods;
                  return Container(
                    margin: EdgeInsets.all(20),
                    height: size.height,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Most Popular Products",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: foods.length,
                            itemBuilder: (context, index) {
                              Food food = foods[index];
                              return Container(
                                margin: EdgeInsets.all(10.0),
                                height: size.height * 0.23,//20
                                width: size.width * 0.04,//0.32
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(//change to stack???
                                  children: [
                                    Text(food.name, textAlign: TextAlign.center,),
                                    Text("${food.price}"),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),//8
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(),
                                        onPressed: () {},
                                        child: Text(
                                          "Add to Cart",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Container(
                    margin: EdgeInsets.all(20),
                    height: size.height,
                    width: double.infinity,
                    color: Colors.white,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

///MyCustomScrollBehavior class allows scrolling to be initiated by both touch gestures and mouse interactions
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
*//////enf of working code