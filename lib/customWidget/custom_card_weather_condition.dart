import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';

class CustomCardWeatherCondition extends StatelessWidget {
  final String weatherConditionImage;
  final double temp;
  final String tempUnit;
  final String weatherCondition;
  final double height;
  final Gradient? gradient;
  const CustomCardWeatherCondition({
    super.key,
    required this.weatherConditionImage,
    required this.temp,
    required this.tempUnit,
    required this.weatherCondition,
    required this.height,
    this.gradient,
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
                offset: const Offset(0, 10),
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
                  alignment: Alignment.topRight,
                  child: Text(
                    "$temp$tempUnit",
                    style: const TextStyle(
                      fontSize: 55,
                      color: Colors.white38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  weatherCondition,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 23,
                  ),
                ),

                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
        Positioned(
          left: 15,
          top: -65,
          child: Image.asset(weatherConditionImage, height: 130, width: 130),
        ),
      ],
    );
  }
}
