import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/customWidget/custom_card_weather_condition.dart';
import 'package:weather_app/customWidget/custom_listview_days.dart';
import 'package:weather_app/customWidget/custom_row_weather_information.dart';
import 'package:weather_app/customWidget/dialog_change_temp_unit.dart';
import 'package:weather_app/model/city_location.dart';

class HomePage extends StatefulWidget {
  final String cityName;
  final String countryName;
  const HomePage({
    super.key,
    required this.cityName,
    required this.countryName,
  });

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  static final String id = "HomePage";

  bool isLoading = true;
  String dayName = DateFormat("EEEE").format(DateTime.now());
  String dayNumber = DateFormat("d").format(DateTime.now());
  String monthName = DateFormat("MMMM").format(DateTime.now());
  String initialUnitTemp = AppStrings.celsiusUnitApi;
  CityLoction cityLocation = CityLoction();

  void buildData() async {
    cityLocation.getCityLocation(widget.cityName).then((_) {
      print("latitude for ${widget.cityName}: ${cityLocation.latitude}");
      print("longitude for ${widget.cityName}: ${cityLocation.longitude}");
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    buildData();
  }

  @override
  Widget build(BuildContext context) {
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
                buildData();
              });
            },
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.cityName}, ${widget.countryName}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              Text(
                isLoading
                    ? AppStrings.loading
                    : "$dayName, $dayNumber $monthName",
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 70),
              CustomCardWeatherCondition(
                id: id,
                height: MediaQuery.heightOf(context) * (20 / 100),
                weatherConditionImage: ImagePaths.heavyCloud,
                temp: isLoading ? 0 : 50,
                tempUnit: AppStrings.celsiusUnit,
                weatherCondition: isLoading
                    ? AppStrings.loading
                    : AppStrings.windSpeed,
              ),
              const SizedBox(height: 60),
              CustomRowWeatherInformation(isLoading: isLoading, id: id),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.today,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              isLoading
                  ? Center(
                      child: Image.asset(
                        ImagePaths.loading,
                        height: 150,
                        width: 150,
                      ),
                    )
                  : CustomListviewDays(
                      id: id,
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
