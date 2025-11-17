import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/screens/choose_city_screen.dart';
import 'package:weather_app/screens/city_weather_details_screen.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Nunito",
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.secondaryColor, size: 30),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        "splashScreen": (context) => const SplashScreen(),
        "chooseCityScreen": (context) => const ChooseCityScreen(),
        "homePage": (context) => const HomePage(),
        "CityWeatherDetailsScreen": (context) => CityWeatherDetailsScreen(),
      },
    );
  }
}
