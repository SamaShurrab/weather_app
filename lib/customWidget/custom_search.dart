import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_strings.dart';

class CustomSearch extends StatelessWidget {
 final void Function(String)? onChanged;
  const CustomSearch({super.key,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 23,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hint: Text(
          AppStrings.hint,
          style: const TextStyle(
            color: Colors.black38,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        suffixIcon: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.search_rounded,
              color: AppColors.secondaryColor,
              size: 30,
            ),
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.secondaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.secondaryColor, width: 2),
        ),
      ),
    );
  }
}
