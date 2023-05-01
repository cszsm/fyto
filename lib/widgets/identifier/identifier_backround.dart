import 'package:flutter/material.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/identifier/parallax_image.dart';

class IdentifierBackground extends StatelessWidget {
  final double pos;

  const IdentifierBackground({
    super.key,
    required this.pos,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final avaliableHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double listHeight = constraints.maxHeight;
        return Stack(
          children: [
            ParallaxImage(
              imagePath: 'assets/images/backgrounds/background1.png',
              color: mixColors(colorScheme.primary, colorScheme.background),
              scrollDelta: pos,
              parentHeight: listHeight,
              avaliableHeight: avaliableHeight,
              parallaxNumber: 6,
            ),
            ParallaxImage(
              imagePath: 'assets/images/backgrounds/background2.png',
              color: mixColors(colorScheme.secondary, colorScheme.background),
              scrollDelta: pos,
              parentHeight: listHeight,
              avaliableHeight: avaliableHeight,
              parallaxNumber: 4,
            ),
            ParallaxImage(
              imagePath: 'assets/images/backgrounds/background3.png',
              color: mixColors(colorScheme.tertiary, colorScheme.background),
              scrollDelta: pos,
              parentHeight: listHeight,
              avaliableHeight: avaliableHeight,
              parallaxNumber: 2,
            ),
          ],
        );
      },
    );
  }
}
