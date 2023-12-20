import 'package:geolocator/geolocator.dart';

class Location {
  late double Latitude;
  late double Longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      Latitude = position.latitude;
      Longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
