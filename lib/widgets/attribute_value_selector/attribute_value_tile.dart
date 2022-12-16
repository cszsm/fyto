import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyto/utils/utils.dart';

class AttributeValueTile extends StatelessWidget {
  final String valueId;
  final bool selected;

  const AttributeValueTile(this.valueId, this.selected);

  @override
  Widget build(BuildContext context) {
    final String attributeName = resolveAttributeValueName(valueId);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(valueId);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(getPictogramPath(valueId),
              width: 60,
              height: 60,
              color: selected ? Colors.green[600] : Colors.black,
              placeholderBuilder: (context) => const SizedBox(
                  height: 60,
                  child: Center(
                    child: Text('haló', style: TextStyle(color: Colors.red)),
                  ))),
          Text("${attributeName[0].toUpperCase()}${attributeName.substring(1)}",
              style: TextStyle(
                color: selected ? Colors.green[600] : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
