import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/customWidget/customButton.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagePaths.logo),
            SizedBox(height: 30),
            Text(
              AppStrings.descriptionTitle,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                shadows: [
                  Shadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(2, 5),
                  ),
                ],
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 15),
            Custombutton(
              onPressed: () {},
              buttonText: AppStrings.getStarted,
              horizontalPadding: MediaQuery.heightOf(context) * (10 / 100),
            ),
          ],
        ),
      ),
    );
  }
}
