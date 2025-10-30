import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/customWidget/custom_card.dart';
import 'package:weather_app/customWidget/custom_search.dart';
import 'package:weather_app/customWidget/custom_snackbar.dart';

class ChooseCityScreen extends StatefulWidget {
  const ChooseCityScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChooseCityScreenState();
  } //createState()
} //ChooseCityScreen class

class ChooseCityScreenState extends State<ChooseCityScreen> {
  int indexSelected = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.secondaryColor,
        onPressed: () {
          if (indexSelected == -1) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackbar.buildSnackBar(AppStrings.pleaseSelectCity),
            );
          } else {}
        },
        child: Icon(Icons.location_on, color: Colors.white, size: 30),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomSearch(),
              const SizedBox(height: 10),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return CustomCard(
                    selectedIndex: indexSelected,
                    cityIndexSelected: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  } //build()
} //ChooseCityScreenState class
