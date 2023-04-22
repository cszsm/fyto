import 'package:flutter/material.dart';

class TileTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  final bool enter;

  const TileTransition({
    super.key,
    required this.animation,
    required this.child,
    required this.enter,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Interval(0, 1.0, curve: enter ? Curves.easeOutCirc : Curves.easeInCirc),
      ),
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animation,
          curve: Interval(0, 1.0,
              curve: enter ? Curves.easeOutCirc : Curves.easeInCirc),
        ),
        child: child,
      ),
    );
  }
}
