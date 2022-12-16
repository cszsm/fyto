import 'package:flutter/material.dart';

class PlantDetailsDescription extends StatelessWidget {
  final String description;

  const PlantDetailsDescription(this.description);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 80, left: 24, right: 24),
        child: Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
