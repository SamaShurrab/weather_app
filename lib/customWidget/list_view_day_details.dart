import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/image_paths.dart';

class ListViewDayDetails extends StatelessWidget {
  final String fulldate;
  final String time;
  const ListViewDayDetails({
    super.key,
    required this.fulldate,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  fulldate,
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                Column(
                  children: [
                    Image.asset(ImagePaths.heavyRain, height: 30, width: 30),
                    Text(
                      "Rainy",
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
