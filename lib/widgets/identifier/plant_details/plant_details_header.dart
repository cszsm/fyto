import 'package:flutter/material.dart';

class PlantDetailsHeader extends StatelessWidget {
  final String name;
  final String latinName;

  const PlantDetailsHeader(this.name, this.latinName, {super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 32,
            color: colorScheme.onBackground,
          ),
        ),
        Text(
          latinName,
          style: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
