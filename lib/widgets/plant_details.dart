import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/utils/utils.dart';

class PlantDetails extends StatelessWidget {
  final Plant plant;

  PlantDetails(this.plant);

  @override
  Widget build(BuildContext context) {
    List<Widget> listAttributes() {
      return plant.attributes.entries.map((e) {
        String attributeType = resolveAttributeType(e.key);
        String attributeValue = resolveAttributeValue(e.value);
        return Text('$attributeType: $attributeValue');
      }).toList();
    }

    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/flower.jpg'),
          Text(plant.name),
          Text(plant.latinName),
          ...listAttributes(),
          Text(plant.description),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
