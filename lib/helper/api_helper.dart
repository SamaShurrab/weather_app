import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/helper/local_storage_data.dart';

class ApiHelper {
  ApiHelper();

  static Future<Map<String, dynamic>> getData(
    double latitude,
    double longitude,
    String apiUrl,
    bool isCity,
  ) async {
    try {
      print(' التحقق من الاتصال بالإنترنت...');

      final connectivityResult = await Connectivity().checkConnectivity();
      bool hasInternet = connectivityResult != ConnectivityResult.none;
      print(' حالة الإنترنت: $hasInternet (${connectivityResult.toString()})');

      if (hasInternet) {
        print(' جاري جلب البيانات من API...');
        try {
          final response = await http
              .get(Uri.parse(apiUrl))
              .timeout(Duration(seconds: 50));

          if (response.statusCode == 200) {
            Map<String, dynamic> weatherDataMap = jsonDecode(response.body);
            print(' تم جلب البيانات من API بنجاح');

            if (!isCity) {
              print(' جاري حفظ البيانات...');
              await LocalStorageData.saveWeatherData(
                latitude,
                longitude,
                weatherDataMap,
              );
              print(' تم حفظ البيانات');
            }

            return weatherDataMap;
          } else {
            print(
              ' خطأ في API: ${response.statusCode} - جاري البحث عن بيانات مخزنة...',
            );
          }
        } catch (apiError) {
          print(
            ' فشل الاتصال بالAPI: $apiError - جاري البحث عن بيانات مخزنة...',
          );
        }
      }

      print('جاري البحث عن بيانات مخزنة...');

      if (!isCity) {
        try {
          Map<String, dynamic> weatherDataOffline =
              await LocalStorageData.getWeatherData(latitude, longitude);
          print('تم العثور على بيانات طقس مخزنة');
          return weatherDataOffline;
        } catch (error) {
          print('لا توجد بيانات مخزنة: $error');
          throw Exception(
            "There is no internet connection and no stored weather data",
          );
        }
      } else {
        throw Exception("No internet connection to search the city");
      }
    } catch (error) {
      print('خطأ في ApiHelper: $error');
      throw Exception("${AppStrings.unexpectedError}: $error");
    }
  }
} //ApiHelper class
