import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/collections.dart';

class CustomRowWeatherInformation extends StatelessWidget {
  final bool isLoading;
  final Map<String, dynamic> weatherMap;
  final String currentDtTxt;

  const CustomRowWeatherInformation({
    super.key,
    required this.isLoading,
    required this.weatherMap,
    required this.currentDtTxt,
  });
  String getWeatherValue(int index) {
    final String cardValue = weatherInformationList[index]["cardValue"];
    final String value = weatherMap[currentDtTxt]?[cardValue].toString() ?? "0";
    final String unit = weatherInformationList[index]["unit"];
    return "$value$unit";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(weatherInformationList.length, (int index) {
        return Column(
          children: [
            Text(
              weatherInformationList[index]["cardName"],
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(vertical: 5),
              color: AppColors.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  weatherInformationList[index]["cardImage"],
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              isLoading ? "0" : getWeatherValue(index),
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      }),
    );
  }
}
