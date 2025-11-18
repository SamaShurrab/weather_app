import 'package:flutter/material.dart';
import 'package:uni_country_city_picker/uni_country_city_picker.dart';
import 'package:weather_app/constants/image_paths.dart';

class BuildCities extends StatelessWidget {
  final City city;
  final int cityIndex;
  final void Function()? onTap;
  final bool isSelected;

  const BuildCities({
    super.key,
    required this.cityIndex,
    required this.city,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: onTap,
            child: Card(
              elevation: 2,
              shadowColor: Colors.grey,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Image.asset(
                      height: 25,
                      width: 25,
                      isSelected ? ImagePaths.checked : ImagePaths.unchecked,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        city.nameEn,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
