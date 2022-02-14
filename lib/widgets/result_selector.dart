import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/plant_details.dart';

class ResultSelector extends StatelessWidget {
  final List<Plant> results;

  ResultSelector(this.results);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlantDetails(results[index])));
          },
          child: Text(results[index].name),
        );
      },
      itemCount: results.length,
    );
  }
}
