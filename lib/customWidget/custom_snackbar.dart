import 'package:flutter/material.dart';

class CustomSnackbar {
  static SnackBar buildSnackBar(String content, Color color) {
    return SnackBar(
      backgroundColor: color,
      showCloseIcon: true,
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}
