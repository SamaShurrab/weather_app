import 'package:flutter/material.dart';

class CustomSnackbar {
  static SnackBar buildSnackBar(String content) {
    return SnackBar(
      backgroundColor: Colors.red,
      showCloseIcon: true,
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }
}
