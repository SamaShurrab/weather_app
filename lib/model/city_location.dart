import 'package:geocoding/geocoding.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';

class CityLocation {
  double latitude = 0;
  double longitude = 0;

  // constructor
  CityLocation();

  Future<void> getCityLocation(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isEmpty) {
        throw Exception("${AppStrings.noFoundCity}$cityName");
      } //if()
      latitude = locations.first.latitude;
      longitude = locations.first.longitude;
    } catch (error) {
      throw Exception("${AppStrings.failedGetData} $error");
    } //catch()
  } //getCityLocation()

  String getImageByweatherTypeCity(String weatherType) {
    switch (weatherType.toLowerCase()) {
      case "thunderstorm":
        return ImagePaths.thunderStorm;
      case "drizzle":
        return ImagePaths.showers;
      case "rain":
        return ImagePaths.heavyRain;
      case "snow":
        return ImagePaths.hail;
      case "clear":
        return ImagePaths.clear;
      case "clouds":
        return ImagePaths.lightCloud;
      case "haze":
        return ImagePaths.heavyCloud;
      case "mist":
        return ImagePaths.snow;
      default:
        return ImagePaths.lightRain;
    }
  }
} //CityLoction class
