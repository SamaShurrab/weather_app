import 'package:geolocator/geolocator.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/model/user_location.dart';

class LocationServices {
  static Future<UserLocation?> getCurrentLocation() async {
    try {
      // Check to location service
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) {
        throw Exception(AppStrings.locationNotEnabled);
      }

      // check to permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception(AppStrings.permissionDeniad);
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception(AppStrings.permissionDeniadForEver);
      }
      print("get user Coordinates (latitude,longitude)");
      // get user Coordinates (latitude,longitude)
      Position userPosition = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.medium),
      );
      print("Sucessful");
      UserLocation userLocation = UserLocation(
        latitude: userPosition.latitude,
        longitude: userPosition.longitude,
      );
      print("latitude:${userLocation.latitude}");
      print("longitude:${userLocation.longitude}");
      return userLocation;
    } catch (error) {
      throw Exception("${AppStrings.locationError}:$error");
    }
  }
}
