import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/screens/choose_city_screen.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/screens/un_known_route_screen.dart';

void main() {
  runApp(const MyApp());
} //main()

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
        "homePage": (context) =>
            const HomePage(cityName: "City", countryName: "Country"),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return const UnKnownRouteScreen();
          },
        );
      },
    );
  } // build()
} // MyApp class
