import 'package:flutter/material.dart';

class ParallaxImage extends StatelessWidget {
  final String imagePath;
  final Color color;
  final double scrollDelta;
  final double parentHeight;
  final double avaliableHeight;
  final double parallaxNumber;

  const ParallaxImage({
    super.key,
    required this.imagePath,
    required this.color,
    required this.scrollDelta,
    required this.parentHeight,
    required this.avaliableHeight,
    required this.parallaxNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: scrollDelta / parentHeight * avaliableHeight / parallaxNumber,
      child: Image.asset(
        imagePath,
        height: avaliableHeight + avaliableHeight / parallaxNumber,
        fit: BoxFit.cover,
        color: color,
      ),
    );
  }
}
