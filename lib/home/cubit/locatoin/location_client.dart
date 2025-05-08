import 'package:geocoding/geocoding.dart' show placemarkFromCoordinates;
import 'package:location/location.dart';

class LocationClient {
  Future<LocationData> getLocation() async {
    return await Location.instance.getLocation();
  }

  Future<String?> getCityFromCoordinates(LocationData location) async {
    final result = await placemarkFromCoordinates(
      location.latitude!,
      location.longitude!,
    );

    return result.firstOrNull?.locality ??
        result.firstOrNull?.administrativeArea;
  }
}
