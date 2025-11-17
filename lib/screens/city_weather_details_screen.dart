import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';

class CityWeatherDetailsScreen extends StatelessWidget {
  const CityWeatherDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String daySelected =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          daySelected,
          style: TextStyle(
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
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
      ),
    );
  }
}
