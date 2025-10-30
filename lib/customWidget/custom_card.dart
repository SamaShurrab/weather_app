import 'package:flutter/material.dart';
import 'package:weather_app/constants/image_paths.dart';

class CustomCard extends StatefulWidget {
  final int selectedIndex;
  final int cityIndexSelected;
  const CustomCard({
    super.key,
    required this.selectedIndex,
    required this.cityIndexSelected,
  });

  @override
  State<StatefulWidget> createState() {
    return CustomCardState();
  }
}

class CustomCardState extends State<CustomCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Card(
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.grey,
          child: InkWell(
            onTap: () {
              setState(() {
                isSelected = widget.cityIndexSelected == widget.selectedIndex;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    isSelected ? ImagePaths.checked : ImagePaths.unchecked,
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "data",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
