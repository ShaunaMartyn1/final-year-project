// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:flutter_app/blocs/geolocation/geolocation_bloc.dart';
import 'package:flutter_app/blocs/location/location_bloc.dart';
import 'package:flutter_app/blocs/place/place_bloc.dart';
import 'package:flutter_app/screens/restaurant_details/restaurant_details_screen.dart';
import 'package:flutter_app/widgets/location_search_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/gmap.dart';

class LocationScreen extends StatelessWidget {
  static const String routeName = '/location';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => LocationScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is LocationLoaded) {
            Set<Marker> markers = state.restaurants!.map(
              (restaurant){
              return Marker(
                markerId: MarkerId(restaurant.id),
                infoWindow: InfoWindow(
                  title: restaurant.name,
                  snippet: restaurant.description,
                  onTap:(){
                    Navigator.pushNamed(
                      context,
                      RestaurantDetailsScreen.routeName,
                      arguments: restaurant,
                    );
                  }),
                position: LatLng(
                  restaurant.address.lat,
                  restaurant.address.lon
                  ),
              );
            }).toSet();
            return Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  buildingsEnabled: false,
                  markers: markers,
                  onMapCreated: (GoogleMapController controller) {
                    context
                        .read<LocationBloc>()
                        .add(LoadMap(controller: controller));
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      state.place.lat,
                      state.place.lon,
                    ),
                    zoom: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/dinner-dash-logo.png',
                            height: 50,
                          ),
                          SizedBox(width: 10,),
                          Expanded(child: LocationSearchBox()),
                        ],
                      ),
                      _SearchBoxSuggestions(),
                      Expanded(child: SizedBox()),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor, fixedSize: Size(200, 40),
                          ),
                          child: Text('Save'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          }),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Text(
              'Something went wrong',
              style: TextStyle(color: Colors.red),
            );
          }
        },
      ),
    );
  }
}

class _SearchBoxSuggestions extends StatelessWidget {
  const _SearchBoxSuggestions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
      builder: (context, state) {
        if (state is AutocompleteLoading) {
          return SizedBox();
        } else if (state is AutocompleteLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
                itemCount: state.autocomplete.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.black.withOpacity(0.6),
                    child: ListTile(
                      title: Text(
                        state.autocomplete[index].description,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      onTap: () {
                        context.read<LocationBloc>().add(
                              SearchLocation(
                                placeId: state.autocomplete[index].placeId,
                              ),
                            );
                        context.read<AutocompleteBloc>().add(ClearAutocomplete());
                      },
                    ),
                  );
                },
              );
          
        } else {
          return Text(
            'Something went wrong',
          );
        }
      },
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 20,
      right: 20,
      child: Container(
        height: 100,
        child: Row(
          children: [
            Image.asset(
              'assets/dinner-dash-logo.png',
              height: 50,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              children: [
                BlocBuilder<AutocompleteBloc, AutocompleteState>(
                  builder: (context, state) {
                    if (state is AutocompleteLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AutocompleteLoaded) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        height: 300,
                        color: state.autocomplete.length > 0
                            ? Colors.black.withOpacity(0.6)
                            : Colors.transparent,
                        child: ListView.builder(
                            itemCount: state.autocomplete.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  state.autocomplete[index].description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                onTap: () {
                                  context.read<LocationBloc>().add(
                                        SearchLocation(
                                          placeId:
                                              state.autocomplete[index].placeId,
                                        ),
                                      );
                                },
                              );
                            }),
                      );
                    } else {
                      return Text(
                        'Something went wrong',
                      );
                    }
                  },
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
