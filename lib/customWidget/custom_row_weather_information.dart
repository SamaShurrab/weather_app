import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/collections.dart';
import 'package:weather_app/screens/home_page.dart';

class CustomRowWeatherInformation extends StatelessWidget {
  final int length = 3;
  final String id;
  final bool isLoading;

  const CustomRowWeatherInformation({
    super.key,
    required this.isLoading,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(length, (int index) {
        return Column(
          children: [
            Text(
              id == HomePageState.id
                  ? weatherInformationList[index]["cardName"]
                  : "",
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
              isLoading ? "0" : "2km/h",
              style: TextStyle(
                color: id == HomePageState.id ? Colors.black : Colors.white,
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
