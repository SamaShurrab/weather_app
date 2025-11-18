import 'package:geocoding/geocoding.dart';
import 'package:weather_app/constants/app_strings.dart';

class CityLoction {
  double latitude = 0;
  double longitude = 0;

  CityLoction();

  Future<void> getCityLocation(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isEmpty) {
        return Future.error("${AppStrings.noFoundCity}$cityName");
      }
      latitude = locations.first.latitude;
      longitude = locations.first.longitude;
    } catch (error) {
      return Future.error(error);
    }
  }
}
