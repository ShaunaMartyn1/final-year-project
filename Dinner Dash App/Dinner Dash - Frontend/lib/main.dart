import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:flutter_app/blocs/basket/basket_bloc.dart';
import 'package:flutter_app/blocs/filters/filters_bloc.dart';
import 'package:flutter_app/blocs/geolocation/geolocation_bloc.dart';
import 'package:flutter_app/blocs/location/location_bloc.dart';
import 'package:flutter_app/blocs/place/place_bloc.dart';
import 'package:flutter_app/blocs/restaurant/restaurant_bloc.dart';
import 'package:flutter_app/config/app_router.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/repositories/geolocation/geolocation_repository.dart';
import 'package:flutter_app/repositories/local_storage/local_storage_repository.dart';
import 'package:flutter_app/repositories/places/places_repo.dart';
import 'package:flutter_app/repositories/restaurant/restaurant_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/theme.dart';
import 'firebase_options.dart';
import 'screens/screens.dart';

//Firebase is called before the app runs
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,); // Ensure plugin services are initialised
    await Hive.initFlutter();
    Hive.registerAdapter(PlaceAdapter());
    {
      runApp(MyApp());
    }
}

//Widgets can access repos with context.read 
class MyApp extends StatelessWidget {
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
          RepositoryProvider<RestaurantRepository>(
            create: (_) => RestaurantRepository(),//might have to change to restaurnt repo???
          ),
          RepositoryProvider<LocalStorageRepository>(
            create: (_) => LocalStorageRepository(),
          ),
        ],
        //Connect blocs to the UI
        child: MultiBlocProvider(
          providers: [
            
            /*BlocProvider(
                create: (context) => GeolocationBloc(
                    geolocationRepository:
                        context.read<GeolocationRepository>())
                  ..add(LoadGeolocation())),*/
            BlocProvider(
                create: (context) => LocationBloc(
                    placesRepository: context.read<PlacesRepository>(),
                        geolocationRepository: context.read<GeolocationRepository>(),
                        localStorageRepository: context.read<LocalStorageRepository>(),
                        restaurantRepository: context.read<RestaurantRepository>()
                )..add(LoadMap()),
            ),
            BlocProvider(
                create: (context) => AutocompleteBloc(
                    placesRepository: context.read<PlacesRepository>())
                  ..add(LoadAutocomplete())),
            /*BlocProvider( not using this anymore 
                create: (context) => PlaceBloc(
                    placesRepository: context.read<PlacesRepository>())),*/
            BlocProvider(
              create: (context) => FiltersBloc(
                restaurantBloc: context.read<RestaurantBloc>(),
              )
                ..add(
                  LoadFilter(),
                ),
            ),
            BlocProvider(
              create: (context) => BasketBloc()
                ..add(
                  StartBasket(),
                ),
                
            ),
            BlocProvider(create: (context) => RestaurantBloc(
              restaurantRepository: context.read<RestaurantRepository>(),
              locationBloc: context.read<LocationBloc>(),
            ),),
          ],
          //Handles navigation
          child: MaterialApp(
            title: 'Food delivery App',
            debugShowCheckedModeBanner: false,
            theme: theme(),//applied globally
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: LocationScreen.routeName, //- Maps - http://localhost:58282/#/location
            //initialRoute: HomeScreen.routeName, //- brings uphomepage -  Set this when finished
            //initialRoute: RestaurantDetailsScreen.routeName,
            //initialRoute: RestaurantListingScreen.routeName,
          ),
        ));
  }
}
