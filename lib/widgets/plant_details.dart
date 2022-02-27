import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/utils/utils.dart';

class PlantDetails extends StatelessWidget {
  final Plant plant;

  PlantDetails(this.plant);

  List<Widget> _listAttributes() {
    return plant.attributes.entries.map((e) {
      String attributeType = resolveAttributeType(e.key);
      String attributeValue = resolveAttributeValue(e.value);
      return Text('$attributeType: $attributeValue');
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset('assets/images/flower.jpg'),
          Text(plant.name),
          Text(plant.latinName),
          ..._listAttributes(),
          Text(plant.description),
        ],
      ),
    );
  }
}
