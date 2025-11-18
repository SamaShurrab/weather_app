import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/customWidget/custom_card_weather_condition.dart';
import 'package:weather_app/customWidget/list_view_day_details.dart';

class CityWeatherDetailsScreen extends StatelessWidget {
  static final String id = "CityWeatherDetailsScreen";
  const CityWeatherDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String daySelected =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          daySelected,
          style: const TextStyle(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: AlignmentGeometry.bottomCenter,
          children: [
            Positioned(
              child: Container(
                width: double.infinity,
                height: MediaQuery.heightOf(context) * (70 / 100),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(150),
                    topRight: Radius.circular(150),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: [
                  CustomCardWeatherCondition(
                    id: id,
                    gradient: LinearGradient(
                      colors: [AppColors.listColor, AppColors.gradiantColor2],
                      begin: AlignmentGeometry.topLeft,
                    ),
                    height: MediaQuery.heightOf(context) * (30 / 100),
                    weatherConditionImage: ImagePaths.heavyCloud,
                    temp: 50,
                    tempUnit: AppStrings.celsiusUnit,
                    weatherCondition: AppStrings.windSpeed,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    flex: 2,
                    child: ListViewDayDetails(fulldate: "2 May,Monday",time: "3:00:00 Am",),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
