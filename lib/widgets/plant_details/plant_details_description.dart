import 'package:flutter/material.dart';

class PlantDetailsDescription extends StatelessWidget {
  final String description;

  const PlantDetailsDescription(this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: colorScheme.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            description,
            style: TextStyle(
              color: colorScheme.onSecondaryContainer,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
