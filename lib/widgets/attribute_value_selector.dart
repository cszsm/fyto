import 'package:flutter/material.dart';
import 'package:fyto/widgets/attribute_value_tile.dart';
import 'package:fyto/data/plant_attribute_values.dart';
import 'package:fyto/data/plant_attributes.dart';

class AttributeValueSelector extends StatelessWidget {
  final String attributeCategoryId;
  final String? selectedAttributeValueId;

  const AttributeValueSelector(this.attributeCategoryId, this.selectedAttributeValueId);

  List<AttributeValueTile> createAttributeValueTiles(context) {
    final attributes = plantAttributes.firstWhere(
            (e) => (e['type'] as String) == attributeCategoryId)['attributes']
        as List<String>;
    return attributes.map((attribute) {
      final attributeName = attributeValues.firstWhere(
          (e) => (e['id'] as String) == attribute)['name'] as String;
      return AttributeValueTile(attributeName, selectedAttributeValueId == attribute, attribute);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: Container(
            width: 100,
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
    );
  }
}
