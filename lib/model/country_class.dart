import 'package:uni_country_city_picker/uni_country_city_picker.dart';

class CountryClass {
  List<Country> countries = [];

  CountryClass();

  Future<List<Country>> getAllCountries() async {
    if (countries.isEmpty) {
      countries = await UniCountryServices.instance.getCountriesAndCities();
    } //if()
    return countries;
  } //getAllCountries ()
} //getAllCitiesByCountryName()
