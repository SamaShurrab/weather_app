import 'package:flutter/material.dart';
import 'package:uni_country_city_picker/uni_country_city_picker.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/customWidget/build_countries_with_cities.dart';
import 'package:weather_app/customWidget/custom_search.dart';
import 'package:weather_app/customWidget/custom_snackbar.dart';
import 'package:weather_app/customWidget/no_data_found_widget.dart';
import 'package:weather_app/model/country_class.dart';

class ChooseCityScreen extends StatefulWidget {
  const ChooseCityScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChooseCityScreenState();
  } //createState()
} //ChooseCityScreen class

class ChooseCityScreenState extends State<ChooseCityScreen> {
  CountryClass countryClass = CountryClass();
  Future<List<Country>>? featchedCountries;
  int selectedCityIndex = -1;
  int selectedCountryIndex = -1;
  City? cityNameSelected;

  /*
  This function assigns the values ​​of the chosen city to variables 
  and will be executed when you click on the city to be selected
  */
  void onCitySelected(int cityIndexP, City cityNameP, int countryIndexP) {
    setState(() {
      selectedCityIndex = cityIndexP;
      cityNameSelected = cityNameP;
      selectedCountryIndex = countryIndexP;
    });
  }

  @override
  void initState() {
    super.initState();
    /*
    Here, data for countries and cities is fetched as soon as 
    you open the screen through the Package uni_country_city_picker
    */
    featchedCountries = countryClass.getAllCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.secondaryColor,
        onPressed: () {
          if (selectedCityIndex == -1) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackbar.buildSnackBar(AppStrings.pleaseSelectCity),
            );
          } else {
            print(selectedCityIndex);
            print(cityNameSelected!.nameEn);
            selectedCityIndex = -1;
            Navigator.of(context).pushNamed("homePage");
          }
        },
        child: const Icon(Icons.location_on, color: Colors.white, size: 30),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        title: Text(
          AppStrings.selectCities,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder(
        future: featchedCountries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Image.asset(ImagePaths.loading));
          } else if (snapshot.hasError) {
            return NoDataFoundWidget(error: snapshot.error);
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSearch(),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: countryClass.countries.length,
                    itemBuilder: (context, countryIndex) {
                      final Country country =
                          countryClass.countries[countryIndex];
                      return BuildCountriesWithCities(
                        countrySelectedIndex: selectedCountryIndex,
                        countryIndex: countryIndex,
                        selectedCityIndex: selectedCityIndex,
                        country: country,
                        onCitySelected: onCitySelected,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  } //build()
} //ChooseCityScreenState class
