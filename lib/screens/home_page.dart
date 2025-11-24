import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/customWidget/custom_card_weather_condition.dart';
import 'package:weather_app/customWidget/custom_error_widget.dart';
import 'package:weather_app/customWidget/custom_listview_days.dart';
import 'package:weather_app/customWidget/custom_row_weather_information.dart';
import 'package:weather_app/customWidget/custom_snackbar.dart';
import 'package:weather_app/customWidget/dialog_change_temp_unit.dart';
import 'package:weather_app/helper/api_helper.dart';
import 'package:weather_app/helper/time_helper.dart';
import 'package:weather_app/model/city_location.dart';
import 'package:weather_app/model/user_location.dart';
import 'package:weather_app/services/location_services.dart';

class HomePage extends StatefulWidget {
  final String cityName;
  final String countryName;
  final bool isCity;

  // constructor
  const HomePage({
    super.key,
    required this.cityName,
    required this.countryName,
    required this.isCity,
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
  CityLocation cityLocation = CityLocation();
  Map<String, dynamic> weatherApiMap = {};
  Map<String, dynamic> weatherMap = {};
  TimeHelper timeHelper = TimeHelper();
  Map<String, dynamic> daysIfoMap = {};
  Future<void>? weatherData;
  UserLocation? userLocation;
  String? cityName;
  String? countryName;

  void buildMapDayInfo() {
    for (var entry in weatherMap.entries) {
      String dayName = DateFormat("EEE").format(DateTime.parse(entry.key));
      Map<String, dynamic> newEntry = {
        "time": entry.key.substring(11, entry.key.length),
        "temp": weatherMap[entry.key]["temp"],
        "weatherMain": weatherMap[entry.key]["weatherMain"],
        "dayFullName": weatherMap[entry.key]["dayName"],
      };

      if (daysIfoMap.containsKey(dayName)) {
        daysIfoMap[dayName].add(newEntry);
      } else {
        daysIfoMap[dayName] = [newEntry];
      }
    } //for()
  } //buildMapDayInfo()

  void buildWeatherMap() {
    if (weatherApiMap["list"] == null || weatherApiMap["list"].isEmpty) {
      throw Exception(AppStrings.failedLoadData);
    } else {
      cityName = widget.isCity
          ? widget.cityName
          : weatherApiMap["city"]["name"];
      countryName = widget.isCity
          ? widget.countryName
          : weatherApiMap["city"]["country"];
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
  } //buildWeatherMapCity()

  Future<void> getUserLocation() async {
    setState(() {
      isLoading = true;
    });
    try {
      print('بدء جلب الموقع...');
      userLocation = await LocationServices.getCurrentLocation();
      if (userLocation != null) {
        print(
          'Successful to get coordinates user: ${userLocation!.latitude}, ${userLocation!.longitude}',
        );
        String urlApi =
            "https://api.openweathermap.org/data/2.5/forecast?lat=${userLocation!.latitude}&lon=${userLocation!.longitude}&appid=${AppStrings.apiKeys}&units=$initialUnitTemp";
        weatherApiMap = await ApiHelper.getData(
          userLocation!.latitude,
          userLocation!.longitude,
          urlApi,
        );
        buildWeatherMap();
        buildMapDayInfo();
        timeHelper.getNearestTime();
        timeHelper.buildCurrentDtTxt();
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      throw Exception(error);
    }
  }

  void checkIsCity() {
    if (widget.isCity) {
      weatherData = loadWeatherData();
    } else {
      weatherData = getUserLocation();
    }
  }

  Future<void> loadWeatherData() async {
    setState(() {
      daysIfoMap = {};
      weatherApiMap = {};
      weatherMap = {};
      isLoading = true;
    });
    try {
      await cityLocation.getCityLocationByName(widget.cityName);
      print("latitude for ${widget.cityName}: ${cityLocation.latitude}");
      print("longitude for ${widget.cityName}: ${cityLocation.longitude}");
      if (cityLocation.latitude == 0 || cityLocation.longitude == 0) {
        throw Exception(AppStrings.invalidCoordinates);
      } else {
        String urlApi =
            "https://api.openweathermap.org/data/2.5/forecast?lat=${cityLocation.latitude}&lon=${cityLocation.longitude}&appid=${AppStrings.apiKeys}&units=$initialUnitTemp";
        weatherApiMap = await ApiHelper.getData(
          cityLocation.latitude,
          cityLocation.longitude,
          urlApi,
        );
        buildWeatherMap();
        buildMapDayInfo();
        timeHelper.getNearestTime();
        timeHelper.buildCurrentDtTxt();
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });

      throw Exception("Failed to fetch weather data: $error");
    }
  } //buildWeatherApiMap()

  bool get isDataLoading =>
      isLoading ||
      timeHelper.currentDtTxt.isEmpty ||
      weatherMap.isEmpty ||
      !weatherMap.containsKey(timeHelper.currentDtTxt);
  @override
  void initState() {
    super.initState();
    checkIsCity();
    print(timeHelper.currentDtTxt);
  } //initState()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              if (isLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackbar.buildSnackBar(AppStrings.waiting, Colors.red),
                );
                return;
              }
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
                widget.isCity
                    ? await loadWeatherData()
                    : await getUserLocation();
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
      body: FutureBuilder(
        future: weatherData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CustomErrorWidget(
              errorTitle: "Error",
              errorDescription: snapshot.error.toString(),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isDataLoading
                        ? AppStrings.loading
                        : "$cityName, $countryName",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    isDataLoading
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
                    height: MediaQuery.of(context).size.height * 0.2,
                    weatherConditionImage: isDataLoading
                        ? ImagePaths.loading
                        : cityLocation.getImageByweatherTypeCity(
                            weatherMap[timeHelper.currentDtTxt]["weatherMain"],
                          ),
                    temp: isDataLoading
                        ? 0
                        : weatherMap[timeHelper.currentDtTxt]["temp"],
                    tempUnit: initialUnitTemp == AppStrings.celsiusUnitApi
                        ? AppStrings.celsiusUnit
                        : AppStrings.fahrenheitUnit,
                    weatherCondition: isDataLoading
                        ? AppStrings.loading
                        : weatherMap[timeHelper.currentDtTxt]["weatherMain"],
                  ),
                  const SizedBox(height: 60),
                  CustomRowWeatherInformation(
                    currentDtTxt: timeHelper.currentDtTxt,
                    isLoading: isLoading,
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
                          daysIfoMap: daysIfoMap,
                          unitTemp: initialUnitTemp == AppStrings.celsiusUnitApi
                              ? AppStrings.celsiusUnit
                              : AppStrings.fahrenheitUnit,
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  } //build()
} //  HomePageState class
