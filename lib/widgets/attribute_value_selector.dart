import 'package:flutter/material.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/attribute_value_tile.dart';
import 'package:fyto/data/plant_attribute_values.dart';
import 'package:fyto/data/plant_attributes.dart';

class AttributeValueSelector extends StatelessWidget {
  final String attributeCategoryId;
  final String? selectedAttributeValueId;

  const AttributeValueSelector(this.attributeCategoryId, this.selectedAttributeValueId);

  List<AttributeValueTile> createAttributeValueTiles(context) {
    final attributes = resolveAttributeValues(attributeCategoryId);
    return attributes.map((attribute) {
      return AttributeValueTile(attribute, selectedAttributeValueId == attribute);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: Container(
            color: Colors.white,
            child: GridView.count(
              controller: scrollController,
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1,
              padding: const EdgeInsets.all(20),
              children: createAttributeValueTiles(context),
            ),
          ),
        );
      },
      expand: false,
      maxChildSize: 1,
      snap: true,
    );
  }
}
