import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/customWidget/custom_row_weather_information.dart';
import 'package:weather_app/screens/city_weather_details_screen.dart';

class CustomCardWeatherCondition extends StatelessWidget {
  final String weatherConditionImage;
  final int temp;
  final String tempUnit;
  final String weatherCondition;
  final double height;
  final Gradient? gradient;
  final String id;
  const CustomCardWeatherCondition({
    super.key,
    required this.weatherConditionImage,
    required this.temp,
    required this.tempUnit,
    required this.weatherCondition,
    required this.height,
    this.gradient,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10),
            color: AppColors.secondaryColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor,
                offset: Offset(0, 10),
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
                    style: const TextStyle(
                      fontSize: 60,
                      color: Colors.white38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  weatherCondition,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                ?id == CityWeatherDetailsScreen.id
                    ? CustomRowWeatherInformation(isLoading: false, id: id)
                    : null,
                const SizedBox(height: 5),
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
