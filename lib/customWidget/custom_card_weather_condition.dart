import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';

class CustomCardWeatherCondition extends StatelessWidget {
  final String weatherConditionImage;
  final int temp;
  final String tempUnit;
  final String weatherCondition;
  const CustomCardWeatherCondition({
    super.key,
    required this.weatherConditionImage,
    required this.temp,
    required this.tempUnit,
    required this.weatherCondition,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.heightOf(context) * (20 / 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.secondaryColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                offset: Offset(0, 15),
                blurRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentGeometry.topRight,
                  child: Text(
                    "$temp$tempUnit",
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.white38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  weatherCondition,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 30,
          top: -70,
          child: Image.asset(weatherConditionImage, height: 150, width: 150),
        ),
      ],
    );
  }
}
