import 'package:flutter/material.dart';
import 'package:weather_app/constants/image_paths.dart';

class NoDataFoundWidget extends StatelessWidget {
  final Object? error;
  const NoDataFoundWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Image.asset(ImagePaths.noDataFound), Text("Error : $error}")],
    );
  }
}
