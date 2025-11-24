import 'package:flutter/material.dart';
import 'package:uni_country_city_picker/uni_country_city_picker.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/customWidget/build_countries_with_cities.dart';
import 'package:weather_app/customWidget/city_search_delegate.dart';
import 'package:weather_app/customWidget/custom_error_widget.dart';
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

  void openSearch(BuildContext context) async {
    final Map<String, dynamic>? listSearch = await showSearch(
      context: context,
      delegate: CitySearchDelegate(countries: countryClass.countries),
    );

    if (listSearch != null && listSearch.isNotEmpty) {
      City city = listSearch["city"];
      Country country = listSearch["country"];

      citySelected = city;
      int countryIndex = countryClass.countries.indexWhere((countryP) {
        return countryP.nameEn == country.nameEn;
      });
      int cityIndex = country.cities.indexWhere((cityP) {
        return cityP.nameEn == city.nameEn;
      });
      if (cityIndex != -1 && countryIndex != -1) {
        setState(() {
          selectedCityIndex = cityIndex;
          selectedCountryIndex = countryIndex;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackbar.buildSnackBar(
            "Selected ${citySelected!.nameEn}",
            Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackbar.buildSnackBar(AppStrings.noFoundCity, Colors.red),
        );
      }
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
          if (selectedCityIndex == -1 || citySelected == null) {
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

            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage(
                        isCity: false,
                        cityName: citySelected!.nameEn,
                        countryName: countryName,
                      );
                    },
                  ),
                )
                .then((_) {
                  setState(() {
                    selectedCityIndex = -1;
                    selectedCountryIndex = -1;
                    citySelected = null;
                  });
                });
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
              openSearch(context);
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
            return CustomErrorWidget(
              errorTitle: AppStrings.citiesNotFound,
              errorDescription: snapshot.error.toString(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) {
                              return HomePage(
                                isCity: false,
                                cityName: AppStrings.loading,
                                countryName: AppStrings.loading,
                              );
                            },
                          ),
                        )
                        .then((_) {
                          setState(() {
                            selectedCityIndex = -1;
                            selectedCountryIndex = -1;
                            citySelected = null;
                          });
                        });
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get My Location Weather",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gradiantColor2,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.ads_click_rounded,
                          color: AppColors.gradiantColor2,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
