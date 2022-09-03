import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AttributeTile extends StatelessWidget {
  final String attributeId;
  final bool selected;
  final String attributeName;

  const AttributeTile(this.attributeId, this.selected, this.attributeName);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () { Navigator.of(context).pop(attributeName); },
          child: SvgPicture.asset(
            'assets/images/viragzat_kunkor.svg',
            width: 60,
            color: selected ? Colors.green[600] : Colors.black,
          ),
        ),
        Text(
          "${attributeId[0].toUpperCase()}${attributeId.substring(1)}",
          style: TextStyle(
            color: selected ? Colors.green[600] : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
