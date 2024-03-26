import 'package:flutter_app/repositories/geolocation/base_geolocation_repo.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationRepository extends BaseGeolocationRepo {
  GeolocationRepository();

  @override
  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location not available');
    } else {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }
  }
}
