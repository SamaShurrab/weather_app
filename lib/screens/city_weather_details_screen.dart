import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/customWidget/custom_card_weather_condition.dart';
import 'package:weather_app/customWidget/list_view_day_details.dart';
import 'package:weather_app/model/city_location.dart';

class CityWeatherDetailsScreen extends StatelessWidget {
  final CityLocation cityLocation;
  final Map<String, dynamic> daysIfoMap;
  final String daySelected;
  final String unitTemp;
  final String dayNamefull;

  // constructor
  const CityWeatherDetailsScreen({
    super.key,
    required this.cityLocation,
    required this.daysIfoMap,
    required this.daySelected,
    required this.unitTemp,
    required this.dayNamefull,
  });

  @override
  Widget build(BuildContext context) {
    final daySelectedList = daysIfoMap[daySelected][0];
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
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
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
                      begin: Alignment.topLeft,
                    ),
                    height: MediaQuery.of(context).size.height * 0.2,
                    weatherConditionImage: cityLocation
                        .getImageByweatherTypeCity(
                          daySelectedList["weatherMain"],
                        ),
                    temp: daySelectedList["temp"],
                    tempUnit: unitTemp,
                    weatherCondition: daySelectedList["weatherMain"],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    flex: 2,
                    child: ListViewDayDetails(
                      daySelected: daySelected,
                      weatherMap: daysIfoMap,
                      cityLocation: cityLocation,
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
