import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/helper/time_helper.dart';
import 'package:weather_app/model/city_location.dart';
import 'package:weather_app/screens/city_weather_details_screen.dart';

class CustomListviewDays extends StatelessWidget {
  final Map<String, dynamic> daysIfoMap;
  final String unitTemp;
  final CityLocation cityLocation;
  final TimeHelper timeHelper;

  const CustomListviewDays({
    super.key,
    required this.daysIfoMap,
    required this.unitTemp,
    required this.cityLocation,
    required this.timeHelper,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: daysIfoMap.length,
        itemBuilder: (context, index) {
          final String currentDay = daysIfoMap.keys.elementAt(index);
          final bool isToday =
             currentDay == timeHelper.dayName;
          final Map<String, dynamic> dayData = daysIfoMap[currentDay][0];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CityWeatherDetailsScreen(
                      unitTemp: unitTemp,
                      cityLocation: cityLocation,
                      dayNamefull: dayData["dayFullName"],
                      daySelected: currentDay,
                      daysIfoMap: daysIfoMap,
                    );
                  },
                ),
              );
            },
            child: SizedBox(
              width: 110,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Card(
                  color: isToday ? AppColors.secondaryColor : Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${dayData["temp"]}$unitTemp",
                        style: TextStyle(
                          color: isToday
                              ? Colors.white
                              : AppColors.secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Image.asset(
                        cityLocation.getImageByweatherTypeCity(
                          dayData["weatherMain"],
                        ),
                        height: 40,
                        width: 40,
                      ),
                      Text(
                        currentDay,
                        style: TextStyle(
                          color: isToday
                              ? Colors.white
                              : AppColors.secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
