import 'package:flutter/material.dart';
import 'package:uni_country_city_picker/uni_country_city_picker.dart';

class CountryHeader extends StatelessWidget {
  final Country country;

  const CountryHeader({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "${country.flag} ${country.nameEn}",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  } //build()
} // CountryHeader class
