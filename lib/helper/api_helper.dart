import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:weather_app/constants/app_strings.dart';

class ApiHelper {
  ApiHelper();

  static Future<Map<String, dynamic>> getData(
    double latitude,
    double longitude,
    String apiUrl,
  ) async {
    Map<String, dynamic> weatherDataMap = {};

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        weatherDataMap = jsonDecode(response.body);
        return weatherDataMap;
      } else {
        Future.error("${AppStrings.failedLoadData}${response.statusCode}");
      }
    } catch (error) {
      return Future.error("${AppStrings.unexpectedError}: $error");
    } //catch()

    return weatherDataMap;
  } //getData()

  
} //ApiHelper class
