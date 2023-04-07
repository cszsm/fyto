import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

SvgPicture categoryTileIcon({
  required String path,
  final Color? color,
  required final Color errorColor,
}) {
  return SvgPicture.asset(
    path,
    width: 32,
    height: 32,
    color: color,
    placeholderBuilder: (context) => SizedBox(
      width: 32,
      height: 32,
      child: Center(
        child: Text(
          'haló',
          style: TextStyle(color: errorColor),
        ),
      ),
    ),
  );
}
