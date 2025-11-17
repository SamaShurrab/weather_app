import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';

class CustomListviewDays extends StatelessWidget {
  final String weatherImageCondition;
  final int temp;
  final String unitTemp;
  const CustomListviewDays({
    super.key,
    required this.weatherImageCondition,
    required this.temp,
    required this.unitTemp,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed("CityWeatherDetailsScreen", arguments: "Sunday");
            },
            child: SizedBox(
              width: 110,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Card(
                  color: index == 1 ? AppColors.secondaryColor : Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "$temp$unitTemp",
                        style: TextStyle(
                          color: index == 1
                              ? Colors.white
                              : AppColors.secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Image.asset(weatherImageCondition, height: 40, width: 40),
                      Text(
                        "Sun",
                        style: TextStyle(
                          color: index == 1
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
