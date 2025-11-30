import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/image_paths.dart';

class NoIntrnet extends StatelessWidget {
  final String cityName;
  const NoIntrnet({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: MediaQuery.of(context).size.height * .1,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(ImagePaths.noIntrnet, fit: BoxFit.contain),
          ),
          const SizedBox(height: 20),
          Text(
            "No internet connection",
            style: TextStyle(
              fontSize: 25,
              color: AppColors.listColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Weather data for the city $cityName be displayed without an internet connection.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
