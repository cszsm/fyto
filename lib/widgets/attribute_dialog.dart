import 'package:flutter/material.dart';
import 'package:fyto/data/plant_attribute_values.dart';
import 'package:fyto/data/plant_attributes.dart';

class AttributeDialog extends StatelessWidget {
  final String attributeId;

  const AttributeDialog(this.attributeId);

  List<ElevatedButton> createAttributeValueButtons(context) {
    final attributes = plantAttributes.firstWhere(
        (e) => (e['type'] as String) == attributeId)['attributes'] as List<String>;
    return attributes.map((attribute) {
      final attributeName = attributeValues
          .firstWhere((e) => (e['id'] as String) == attribute)['name'] as String;
      return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(attribute);
        },
        child: Text(attributeName),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: createAttributeValueButtons(context),
        ),
      ),
    );
  }
}
