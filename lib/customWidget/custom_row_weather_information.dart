import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/collections.dart';

class CustomRowWeatherInformation extends StatelessWidget {
  final int length = 3;
  const CustomRowWeatherInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(length, (int index) {
        return Column(
          children: [
            Text(
              weatherInformationList[index]["cardName"],
              style: TextStyle(
                color: Colors.black45,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Card(
              elevation: 0,
              margin: EdgeInsets.symmetric(vertical: 5),
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
              "2km/h",
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
