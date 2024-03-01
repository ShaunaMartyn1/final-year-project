import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/AIBloc/ai_bloc_bloc.dart';
import 'package:flutter_app/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:flutter_app/blocs/basket/basket_bloc.dart';
import 'package:flutter_app/blocs/filters/filters_bloc.dart';
import 'package:flutter_app/blocs/geolocation/geolocation_bloc.dart';
import 'package:flutter_app/blocs/place/place_bloc.dart';
import 'package:flutter_app/config/app_router.dart';
import 'package:flutter_app/repositories/geolocation/geolocation_repository.dart';
import 'package:flutter_app/repositories/places/places_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme.dart';
import 'screens/screens.dart';

//import 'package:tflite/tflite.dart';
import 'package:tflite_flutter/tflite_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugin services are initialised
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key}); - original line
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<GeolocationRepository>(
            create: (_) => GeolocationRepository(),
          ),
          RepositoryProvider<PlacesRepository>(
            create: (_) => PlacesRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => GeolocationBloc(
                    geolocationRepository:
                        context.read<GeolocationRepository>())
                  ..add(LoadGeolocation())),
            BlocProvider(
                create: (context) => AutocompleteBloc(
                    placesRepository: context.read<PlacesRepository>())
                  ..add(LoadAutocomplete(searchInput: 'Initial Value'))),
            BlocProvider(
                create: (context) => PlaceBloc(
                    placesRepository: context.read<PlacesRepository>())),
            BlocProvider(
              create: (context) => FiltersBloc()
                ..add(
                  FilterLoad(),
                ),
            ),
            BlocProvider(
              create: (context) => BasketBloc()
                ..add(
                  StartBasket(),
                ),
            ),
            BlocProvider(
              create: (context) => AIBloc(),
            ),
          ],
          child: MaterialApp(
            title: 'Food delivery App',
            debugShowCheckedModeBanner: false,
            theme: theme(),
            onGenerateRoute: AppRouter.onGenerateRoute,
            //initialRoute: LocationScreen.routeName, - Maps - http://localhost:58282/#/location
            initialRoute: HomeScreen
                .routeName, //- brings uphomepage -  Set this when finished
            //initialRoute: RestaurantDetailsScreen.routeName,
            //initialRoute: RestaurantListingScreen.routeName,
          ),
        ));
  }
}
