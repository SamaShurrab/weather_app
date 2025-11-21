import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/customWidget/custom_error_widget.dart';

class UnKnownRouteScreen extends StatelessWidget {
  const UnKnownRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.pageNotFound,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
      ),
      body: CustomErrorWidget(
        errorTitle: "Error",
        errorDescription: AppStrings.errorDescription,
      ),
    );
  }
}
