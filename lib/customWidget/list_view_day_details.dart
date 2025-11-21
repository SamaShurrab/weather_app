import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/model/city_location.dart';

class ListViewDayDetails extends StatelessWidget {
  final String daySelected;
  final Map<String, dynamic> weatherMap;
  final CityLocation cityLocation;

  const ListViewDayDetails({
    super.key,
    required this.daySelected,
    required this.weatherMap,
    required this.cityLocation,
  });

  String putTimePeriodImage(int time) {
    if (time >= 12 && time < 24) {
      return ImagePaths.pm;
    }
    return ImagePaths.am;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dayInfoList = weatherMap[daySelected];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dayInfoList.length,
      itemBuilder: (context, index) {
        final value = weatherMap[daySelected][index];
        String time = value["time"];
        String weatherMain = value["weatherMain"];
        int hour = int.parse(time.substring(0, 2));
        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(putTimePeriodImage(hour), height: 40, width: 40),
                const SizedBox(width: 10),
                Text(
                  time,
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 40),
                Text(
                  "${value["temp"]}${AppStrings.tempUnit}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 50),
                Column(
                  children: [
                    Image.asset(
                      cityLocation.getImageByweatherTypeCity(weatherMain),
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      weatherMain,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
