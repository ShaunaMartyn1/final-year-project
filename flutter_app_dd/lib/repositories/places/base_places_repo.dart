import 'package:flutter_app/models/place_autocomplete_model.dart';
import 'package:flutter_app/models/place_model.dart';

abstract class BasePlacesRepo {
  Future<List<PlaceAutocomplete>?> getAutocomplete(String searchInput) async {}

  Future<Place?> getPlace(String placeId) async {}
}