import 'package:flutter/material.dart';
import 'package:uni_country_city_picker/uni_country_city_picker.dart';
import 'package:weather_app/customWidget/build_cities.dart';
import 'package:weather_app/customWidget/country_header.dart';

class BuildCountriesWithCities extends StatelessWidget {
  final Country country;
  final void Function(int cityIndexP, City cityNameP, int countryIndex)
  onCitySelected;
  final int selectedCityIndex;
  final int countrySelectedIndex;
  final int countryIndex;
  const BuildCountriesWithCities({
    super.key,
    required this.country,
    required this.onCitySelected,
    required this.selectedCityIndex,
    required this.countrySelectedIndex,
    required this.countryIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CountryHeader(country: country),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: country.cities.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, cityIndex) {
            final City city = country.cities[cityIndex];
            bool isSelected =
                cityIndex == selectedCityIndex &&
                countrySelectedIndex == countryIndex;
            return BuildCities(
              cityIndex: cityIndex,
              city: city,
              onTap: () {
                onCitySelected(cityIndex, city, countryIndex);
              },
              isSelected: isSelected,
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
