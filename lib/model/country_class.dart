import 'package:uni_country_city_picker/uni_country_city_picker.dart';

class CountryClass {
  List<Country> countries = [];

  CountryClass();

  Future<List<Country>> getAllCountries() async {
    if (countries.isEmpty) {
      try {
        countries = await UniCountryServices.instance.getCountriesAndCities();
      } catch (error) {
        return Future.error(error);
      }
    } //if()
    return List.from(countries);
  } //getAllCountries ()
} //CountryClass()
