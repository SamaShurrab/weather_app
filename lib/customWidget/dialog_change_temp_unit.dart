import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/customWidget/custom_button.dart';
import 'package:weather_app/customWidget/custom_snackbar.dart';

class DialogChangeTempUnit extends StatefulWidget {
  const DialogChangeTempUnit({super.key});

  @override
  State<StatefulWidget> createState() {
    return DialogChangeTempUnitState();
  }
}

class DialogChangeTempUnitState extends State<DialogChangeTempUnit> {
  String? selectedUnit;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppStrings.changeTemp,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 21,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  AppStrings.changeTemp,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,

                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                    hint: Text(
                      AppStrings.unit,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.secondaryColor,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(30),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    dropdownColor: AppColors.secondaryColor,
                    items: [AppStrings.celsius, AppStrings.fahrenheit]
                        .map(
                          (tempUnit) => DropdownMenuItem(
                            value: tempUnit,
                            child: Text(
                              tempUnit,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedUnit = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Custombutton(
          buttonText: AppStrings.convert,
          onPressed: () {
            if (selectedUnit == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackbar.buildSnackBar(
                  AppStrings.pleaseSelectUnitTemp,
                  Colors.red,
                ),
              );
            } else {
              final String unitForApi = selectedUnit == AppStrings.fahrenheit
                  ? AppStrings.fahrenheitUnitApi
                  : AppStrings.celsiusUnitApi;

              Navigator.of(context).pop(unitForApi);
            }
          },
          horizontalPadding: 30,
        ),
        Custombutton(
          horizontalPadding: 30,
          buttonText: AppStrings.cancel,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
