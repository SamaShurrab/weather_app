import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/user_location.dart';

class LocalStorageData {
  static Future<void> saveUserLocation(UserLocation userLocation) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setDouble("lat", userLocation.latitude);
      sharedPreferences.setDouble("long", userLocation.longitude);
      print("Sucessful save user location without Intrnet");
    } catch (error) {
      print("Error saveUserLocation()");
      throw Exception("Error to save user location:$error");
    }
  } //saveUserLocation()

  static Future<UserLocation?> getUserLocation() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final double? latitudeUser = sharedPreferences.getDouble("lat");
      final double? longitudeUser = sharedPreferences.getDouble("long");
      if (latitudeUser != null && longitudeUser != null) {
        return UserLocation(latitude: latitudeUser, longitude: longitudeUser);
      }
    } catch (error) {
      print("Error getUserLocation()");
      throw Exception(error);
    }
    return null;
  } //getUserLocation()

  static Future<void> saveWeatherData(
    double lat,
    double long,
    Map<String, dynamic> weatherData,
  ) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String key = "weather_${lat}_$long";
      await sharedPreferences.setString(key, json.encode(weatherData));
      print("save weather Data");
    } catch (error) {
      print("Error saveWeatherData()");
      throw Exception("Error to Save Weather Data:$error");
    }
  } //saveWeatherData()

  static Future<Map<String, dynamic>> getWeatherData(
    double lat,
    double long,
  ) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String key = "weather_${lat}_$long";
      final String? data = sharedPreferences.getString(key);
      if (data != null) {
        return json.decode(data);
      } else {
        throw Exception("No weather data is stored for this location.");
      }
    } catch (error) {
      print("Error getWeatherData()");
      throw Exception("Error retrieving stored data:$error");
    }
  } //getWeatherData()

  static Future<bool> hasWeatherData(double lat, double long) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String key = "weather_${lat}_$long";
      return sharedPreferences.containsKey(key);
    } catch (error) {
      throw Exception("Data verification error:$error");
    }
  }
}
