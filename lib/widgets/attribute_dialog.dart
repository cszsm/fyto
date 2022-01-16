import 'package:flutter/material.dart';
import 'package:fyto/data/plant_attributes.dart';

class AttributeDialog extends StatelessWidget {
  static List<ElevatedButton> createAttributeValueButtons(context) {
    return plantAttributeValues
        .map((attributeValue) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(attributeValue);
              },
              child: Text(attributeValue),
            ))
        .toList();
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
