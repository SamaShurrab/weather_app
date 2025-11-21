import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/helper/time_helper.dart';
import 'package:weather_app/model/city_location.dart';
import 'package:weather_app/screens/city_weather_details_screen.dart';

class CustomListviewDays extends StatelessWidget {
  final Map<String, dynamic> daysIfoMap;
  final String unitTemp;
  final String id;
  final CityLoction cityLocation;
  final TimeHelper timeHelper;

  const CustomListviewDays({
    super.key,
    required this.daysIfoMap,
    required this.unitTemp,
    required this.id,
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
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CityWeatherDetailsScreen(
                      unitTemp: unitTemp,
                      cityLoction: cityLocation,
                      dayNamefull:
                          daysIfoMap[daysIfoMap.keys.elementAt(
                            index,
                          )][0]["dayFullName"],
                      daySelected: daysIfoMap.keys.elementAt(index),
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
                  color: daysIfoMap.keys.elementAt(index) == timeHelper.dayName
                      ? AppColors.secondaryColor
                      : Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${daysIfoMap[daysIfoMap.keys.elementAt(index)][0]["temp"]}$unitTemp",
                        style: TextStyle(
                          color:
                              daysIfoMap.keys.elementAt(index) ==
                                  timeHelper.dayName
                              ? Colors.white
                              : AppColors.secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Image.asset(
                        cityLocation.getImageByweatherTypeCity(
                          daysIfoMap[daysIfoMap.keys.elementAt(
                            index,
                          )][0]["weatherMain"],
                        ),
                        height: 40,
                        width: 40,
                      ),
                      Text(
                        daysIfoMap.keys.elementAt(index),
                        style: TextStyle(
                          color:
                              daysIfoMap.keys.elementAt(index) ==
                                  timeHelper.dayName
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
