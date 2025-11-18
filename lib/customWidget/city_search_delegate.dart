import 'package:flutter/material.dart';
import 'package:uni_country_city_picker/uni_country_city_picker.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/image_paths.dart';

class CitySearchDelegate extends SearchDelegate<Map<String, dynamic>> {
  List<Country> countries;

  CitySearchDelegate({required this.countries});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 20,
          color: Colors.white60,
          fontWeight: FontWeight.w600,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      appBarTheme: AppBarTheme(backgroundColor: AppColors.secondaryColor),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isEmpty)
        IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.search_rounded, color: Colors.white, size: 30),
        ),
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close_rounded, color: Colors.red, size: 30),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.white),
      onPressed: () {
        close(context, {});
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchResult();
  }

  Country? findCountryForCity(City targetCity) {
    for (Country country in countries) {
      if (country.cities.contains(targetCity)) {
        return country;
      }
    }
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Image.asset(
          ImagePaths.noDataFound,
          width: 300,
          height: 300,
          fit: BoxFit.fill,
        ),
      );
    }
    return buildSearchResult();
  }

  Widget buildSearchResult() {
    final List<City> allCities = [];

    // to add all cities for all country
    for (Country country in countries) {
      allCities.addAll(country.cities);
    }

    final searchResult = query.isEmpty
        ? allCities
        : allCities.where((city) {
            return city.nameEn.toLowerCase().contains(query.toLowerCase());
          }).toList();

    if (searchResult.isEmpty) {
      return Column(
        children: [
          Center(
            child: Image.asset(
              ImagePaths.noDataFound,
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            "No results found for $query",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }
    return ListView.builder(
      itemCount: searchResult.length,
      itemBuilder: (context, cityIndex) {
        final City city = searchResult[cityIndex];
        final Country country = findCountryForCity(city)!;
        return InkWell(
          onTap: () {
            close(context, {"city": city, "country": country});
          },
          child: SizedBox(
            height: 90,
            child: Card(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              color: Colors.white,
              elevation: 2,
              shadowColor: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "${country.flag} ${country.nameEn} ,${city.nameEn}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
