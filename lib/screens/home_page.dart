import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/customWidget/custom_card_weather_condition.dart';
import 'package:weather_app/customWidget/custom_listview_days.dart';
import 'package:weather_app/customWidget/custom_row_weather_information.dart';
import 'package:weather_app/customWidget/dialog_change_temp_unit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  bool isLoading = false;
  String dayName = DateFormat("EEEE").format(DateTime.now());
  String dayNumber = DateFormat("d").format(DateTime.now());
  String monthName = DateFormat("MMMM").format(DateTime.now());
  String initialUnitTemp = AppStrings.celsiusUnitApi;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final cityName = args["cityName"];
    final countryname = args["countryName"];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return DialogChangeTempUnit();
                },
              ).then((String? selectedUnit) {
                if (selectedUnit != null) {
                  setState(() {
                    initialUnitTemp = selectedUnit;
                    isLoading = true;
                    print("Selected unit: $initialUnitTemp");
                  });
                }
              });
            },
            icon: Icon(Icons.settings_rounded),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$cityName, $countryname",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              Text(
                isLoading
                    ? AppStrings.loading
                    : "$dayName, $dayNumber $monthName",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 70),
              CustomCardWeatherCondition(
                weatherConditionImage: ImagePaths.heavyCloud,
                temp: 50,
                tempUnit: AppStrings.celsiusUnit,
                weatherCondition: AppStrings.windSpeed,
              ),
              const SizedBox(height: 60),
              CustomRowWeatherInformation(),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.today,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              CustomListviewDays(
                weatherImageCondition: ImagePaths.snow,
                temp: 15,
                unitTemp: AppStrings.celsiusUnit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
