import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/customWidget/custom_card_weather_condition.dart';
import 'package:weather_app/customWidget/list_view_day_details.dart';
import 'package:weather_app/model/city_location.dart';

class CityWeatherDetailsScreen extends StatelessWidget {
  final CityLoction cityLoction;
  final Map<String, dynamic> daysIfoMap;
  final String daySelected;
  final String unitTemp;
  final String dayNamefull;

  // constructor
  const CityWeatherDetailsScreen({
    super.key,
    required this.cityLoction,
    required this.daysIfoMap,
    required this.daySelected,
    required this.unitTemp,
    required this.dayNamefull,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          dayNamefull,
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 65),
              child: Column(
                children: [
                  CustomCardWeatherCondition(
                    gradient: LinearGradient(
                      colors: [AppColors.listColor, AppColors.gradiantColor2],
                      begin: AlignmentGeometry.topLeft,
                    ),
                    height: MediaQuery.heightOf(context) * (20 / 100),
                    weatherConditionImage: cityLoction
                        .getImageByweatherTypeCity(
                          daysIfoMap[daySelected][0]["weatherMain"],
                        ),
                    temp: daysIfoMap[daySelected][0]["temp"],
                    tempUnit: unitTemp,
                    weatherCondition: daysIfoMap[daySelected][0]["weatherMain"],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    flex: 2,
                    child: ListViewDayDetails(
                      daySelected: daySelected,
                      weatherMap: daysIfoMap,
                      cityLoction: cityLoction,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } //build()
} // CityWeatherDetailsScreen class
