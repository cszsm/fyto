import 'package:flutter/material.dart';

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: SizedBox(
        height: 24,
        child: Icon(
          Icons.horizontal_rule_rounded,
          size: 36,
          color: colorScheme.outline,
        ),
      ),
    );
  }
}
