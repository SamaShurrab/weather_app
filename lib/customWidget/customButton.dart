import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';

class Custombutton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonText;
  final double horizontalPadding;
  const Custombutton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.secondaryColor,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 12,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
