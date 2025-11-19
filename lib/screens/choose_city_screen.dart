import 'package:flutter/material.dart';
import 'package:uni_country_city_picker/uni_country_city_picker.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/customWidget/build_countries_with_cities.dart';
import 'package:weather_app/customWidget/city_search_delegate.dart';
import 'package:weather_app/customWidget/custom_snackbar.dart';
import 'package:weather_app/model/country_class.dart';
import 'package:weather_app/screens/home_page.dart';

class ChooseCityScreen extends StatefulWidget {
  // constructor
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
  City? citySelected;

  /*
  This function assigns the values ​​of the chosen city to variables 
  and will be executed when you click on the city to be selected
  */
  void onCitySelected(int cityIndexP, City citySelectedP, int countryIndexP) {
    setState(() {
      selectedCityIndex = cityIndexP;
      citySelected = citySelectedP;
      selectedCountryIndex = countryIndexP;
    });
  } //onCitySelected()

  void openSearch() async {
    final Map<String, dynamic>? listSearch = await showSearch(
      context: context,
      delegate: CitySearchDelegate(countries: countryClass.countries),
    );

    if (listSearch!.isNotEmpty) {
      setState(() {
        City city = listSearch["city"];
        Country country = listSearch["country"];
        setState(() {
          citySelected = city;
          selectedCountryIndex = countryClass.countries.indexOf(country);
          selectedCityIndex = country.cities.indexOf(city);
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar.buildSnackBar(
          "Selected ${citySelected!.nameEn}",
          Colors.green,
        ),
      );
    } //if()
  } // openSearch()

  @override
  void initState() {
    super.initState();
    /*
    Here, data for countries and cities is fetched as soon as 
    you open the screen through the Package uni_country_city_picker
    */
    featchedCountries = countryClass.getAllCountries();
  } //initState()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.secondaryColor,
        onPressed: () {
          if (selectedCityIndex == -1) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackbar.buildSnackBar(
                AppStrings.pleaseSelectCity,
                Colors.red,
              ),
            );
          } else {
            String countryName = countryClass.countries
                .elementAt(selectedCountryIndex)
                .nameEn;
            selectedCityIndex = -1;
            selectedCountryIndex = -1;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage(
                    cityName: citySelected!.nameEn,
                    countryName: countryName,
                  );
                },
              ),
            );
          }
        },
        child: const Icon(Icons.location_on, color: Colors.white, size: 30),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        title: Text(
          AppStrings.selectCities,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              openSearch();
            },
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: featchedCountries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Image.asset(ImagePaths.loading));
          } else if (snapshot.hasError) {
            return Center(
              child: Image.asset(
                ImagePaths.noDataFound,
                width: 300,
                height: 300,
                fit: BoxFit.fill,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
