import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyto/data/plant_attribute_types.dart';
import 'package:fyto/data/plant_attribute_values.dart';
import 'package:fyto/widgets/attribute_category_tile.dart';
import 'package:fyto/widgets/attribute_value_selector.dart';

class AttributeSelector extends StatefulWidget {
  final Function onSelectionChanged;

  const AttributeSelector(this.onSelectionChanged);

  @override
  State<StatefulWidget> createState() {
    return _AttributeSelectorState();
  }
}

class _AttributeSelectorState extends State<AttributeSelector> {
  final Map<String, String> selection = {};

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: attributeTypes.length,
      itemBuilder: (BuildContext context, int index) {
        final attribute = attributeTypes.elementAt(index);
        final attributeId = attribute['id'] as String;
        final selectedAttributeValueId = selection[attributeId];

        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 400 : 0,
            bottom: index == attributeTypes.length - 1 ? 80 : 0,
          ),
          child:
              AttributeCategoryTile(attributeId, selectedAttributeValueId, (newSelectedValueId) {
            setState(() {

              if (selection[attributeId] == newSelectedValueId) {
                selection.remove(attributeId);
              } else {
                selection[attributeId] = newSelectedValueId!;
              }
            });

            widget.onSelectionChanged(selection);
          }),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }
}
