import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';

final List<Map<String, dynamic>> weatherInformationList = [
  {
    "cardName": AppStrings.windSpeed,
    "cardImage": ImagePaths.windSpeed,
    "cardValue": "windSpeed",
    "unit": "km/h",
  },
  {
    "cardName": AppStrings.humidity,
    "cardImage": ImagePaths.humidity,
    "cardValue": "humidity",
    "unit": "",
  },
  {
    "cardName": AppStrings.maxTemp,
    "cardImage": ImagePaths.maxTemp,
    "cardValue": "temp_max",
    "unit": AppStrings.tempUnit,
  },
];
