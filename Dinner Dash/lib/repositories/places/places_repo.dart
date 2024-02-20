import 'dart:convert' as convert;

import 'package:flutter_app/models/place_autocomplete_model.dart';
import 'package:flutter_app/models/place_model.dart';
import 'package:flutter_app/repositories/places/base_places_repo.dart';
import 'package:http/http.dart' as http;

class PlacesRepository extends BasePlacesRepo{
  final String key = 'AIzaSyBShakjx4F_Sf8raxMIPkIT2vNxqHi1sLQ';// check this its the web key
  final String types = 'geocode';

  Future<List<PlaceAutocomplete>> getAutocomplete(String searchInput) async{
    final String url =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['predictions'] as List;

    return results.map((place) => PlaceAutocomplete.fromJson(place)).toList();
  }

  @override
  Future<Place?> getPlace(String placeId) async{
    final String url =
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var result = json['result'] as Map<String, dynamic>;

    return Place.fromJson(result);
  }
}