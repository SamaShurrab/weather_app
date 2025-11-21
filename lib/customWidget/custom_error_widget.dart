import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorTitle;
  final String errorDescription;
  const CustomErrorWidget({
    super.key,
    required this.errorTitle,
    required this.errorDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.center,
      child: SizedBox(
        height: MediaQuery.heightOf(context) * (30 / 100),
        width: MediaQuery.heightOf(context) * (30 / 100),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.red[100],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              const Icon(Icons.error, color: Colors.red, size: 50),
              const SizedBox(height: 10),
              Text(
                errorTitle,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Text(
                  errorDescription,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
