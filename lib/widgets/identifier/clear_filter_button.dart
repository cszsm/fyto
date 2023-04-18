import 'package:flutter/material.dart';

class ClearFilterButton extends StatelessWidget {
  final Function onTap;

  const ClearFilterButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Material(
      // shape: const CircleBorder(),
      color: Colors.transparent,
      child: Ink(
        padding: EdgeInsets.zero,
        width: 38,
        height: 38,
        decoration: ShapeDecoration(
          color: colorScheme.tertiaryContainer.withOpacity(0.7),
          shape: const CircleBorder(),
        ),
        child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.clear,
              size: 28,
            ),
            onPressed: () => onTap()),
      ),
    );
  }
}
