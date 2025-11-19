import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/customWidget/custom_card_weather_condition.dart';
import 'package:weather_app/customWidget/custom_listview_days.dart';
import 'package:weather_app/customWidget/custom_row_weather_information.dart';
import 'package:weather_app/customWidget/dialog_change_temp_unit.dart';
import 'package:weather_app/helper/api_helper.dart';
import 'package:weather_app/helper/time_helper.dart';
import 'package:weather_app/model/city_location.dart';

class HomePage extends StatefulWidget {
  final String cityName;
  final String countryName;

  // constructor
  const HomePage({
    super.key,
    required this.cityName,
    required this.countryName,
  });

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  } //createState()
} // HomePage class

class HomePageState extends State<HomePage> {
  static final String id = "HomePage";
  bool isLoading = true;

  String initialUnitTemp = AppStrings.celsiusUnitApi;
  CityLoction cityLocation = CityLoction();
  Map<String, dynamic> weatherApiMap = {};
  Map<String, dynamic> weatherMap = {};
  TimeHelper timeHelper = TimeHelper();
  Map<String, dynamic> daysIfoMap = {};

  void buildMapDayInfo() {
    for (var entry in weatherMap.entries) {
      String dayName = DateFormat("EEE").format(DateTime.parse(entry.key));
      if (!daysIfoMap.containsKey(dayName)) {
        daysIfoMap[dayName] = {
          "temp": weatherMap[entry.key]["temp"],
          "weatherMain": weatherMap[entry.key]["weatherMain"],
        };
      }
    } //for()
  } //buildMapDayInfo()

  void buildWeatherMap() {
    if (weatherApiMap["list"].isEmpty) {
      print(AppStrings.failedLoadData);
    } else {
      for (int i = 0; i < weatherApiMap["list"].length; i++) {
        final int dt = weatherApiMap["list"][i]["dt"];
        final String dtTxtKey = weatherApiMap["list"][i]["dt_txt"];
        if (!weatherMap.containsKey(dtTxtKey)) {
          weatherMap[dtTxtKey] = {
            "temp": weatherApiMap["list"][i]["main"]["temp"],
            "temp_max": weatherApiMap["list"][i]["main"]["temp_max"],
            "humidity": weatherApiMap["list"][i]["main"]["humidity"],
            "weatherMain": weatherApiMap["list"][i]["weather"][0]["main"],

            "windSpeed": weatherApiMap["list"][i]["wind"]["speed"],
            "dayName": timeHelper.getDayName(dt),
          };
        } //if()
      } //for()
    } //else
  } //buildWeatherMap()

  Future<void> buildWeatherApiMap() async {
    setState(() {
      weatherApiMap = {};
      weatherMap = {};
      isLoading = true;
    });
    await cityLocation.getCityLocation(widget.cityName);
    print("latitude for ${widget.cityName}: ${cityLocation.latitude}");
    print("longitude for ${widget.cityName}: ${cityLocation.longitude}");
    if (cityLocation.latitude == 0 || cityLocation.longitude == 0) {
      Future.error(AppStrings.invalidCoordinates);
    } else {
      String urlApi =
          "https://api.openweathermap.org/data/2.5/forecast?lat=${cityLocation.latitude}&lon=${cityLocation.longitude}&appid=${AppStrings.apiKeys}&units=$initialUnitTemp";
      weatherApiMap = await ApiHelper.getData(
        cityLocation.latitude,
        cityLocation.longitude,
        urlApi,
      );
      setState(() {
        isLoading = false;
      });
    }
  } //buildData()

  @override
  void initState() {
    super.initState();
    buildWeatherApiMap().then((_) {
      buildWeatherMap();
      buildMapDayInfo();
      timeHelper.getNearestTime();
      timeHelper.buildCurrentDtTxt();
      print(timeHelper.buildCurrentDtTxt());
      print(timeHelper.currentDtTxt);
    });
  } //initState()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              showDialog<String>(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return DialogChangeTempUnit();
                },
              ).then((String? selectedUnit) async {
                if (selectedUnit != null) {
                  setState(() {
                    initialUnitTemp = selectedUnit;
                    isLoading = true;
                    print("Selected unit: $initialUnitTemp");
                  });
                }
                await buildWeatherApiMap();
                buildWeatherMap();
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
                    : "${timeHelper.dayNameFull}, ${timeHelper.dayNumber} ${timeHelper.monthName}",
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 70),
              CustomCardWeatherCondition(
                height: MediaQuery.heightOf(context) * (20 / 100),
                weatherConditionImage:
                    isLoading ||
                        timeHelper.currentDtTxt.isEmpty ||
                        weatherMap.isEmpty
                    ? ImagePaths.loading
                    : cityLocation.getImageByweatherTypeCity(
                        weatherMap[timeHelper.currentDtTxt]["weatherMain"],
                      ),
                temp:
                    isLoading ||
                        timeHelper.currentDtTxt.isEmpty ||
                        weatherMap.isEmpty
                    ? 0
                    : weatherMap[timeHelper.currentDtTxt]["temp"],
                tempUnit: initialUnitTemp == AppStrings.celsiusUnitApi
                    ? AppStrings.celsiusUnit
                    : AppStrings.fahrenheitUnit,
                weatherCondition:
                    isLoading ||
                        timeHelper.currentDtTxt.isEmpty ||
                        weatherMap.isEmpty
                    ? AppStrings.loading
                    : weatherMap[timeHelper.currentDtTxt]["weatherMain"],
              ),
              const SizedBox(height: 60),
              CustomRowWeatherInformation(
                currentDtTxt: timeHelper.currentDtTxt,
                isLoading: isLoading,
                id: id,
                weatherMap: weatherMap,
              ),
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
                      timeHelper: timeHelper,
                      cityLocation: cityLocation,
                      id: id,
                      daysIfoMap: daysIfoMap,
                      unitTemp: initialUnitTemp == AppStrings.celsiusUnitApi
                          ? AppStrings.celsiusUnit
                          : AppStrings.fahrenheitUnit,
                    ),
            ],
          ),
        ),
      ),
    );
  } //build()
} //  HomePageState class
