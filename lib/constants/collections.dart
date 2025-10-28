import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';

class Collections {
  static List<Map<String, dynamic>> weatherInformationList = [
    {
      "cardName": AppStrings.windSpeed,
      "cardImage": ImagePaths.windSpeed,
      "cardValue": "windSpeed",
    },
    {
      "cardName": AppStrings.humidity,
      "cardImage": ImagePaths.humidity,
      "cardValue": "humidity",
    },
    {
      "cardName": AppStrings.maxTemp,
      "cardImage": ImagePaths.maxTemp,
      "cardValue": "temp_max",
    },
  ];
}
