import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/result_tile.dart';

class ResultSelector extends StatelessWidget {
  final List<Plant> results;

  const ResultSelector(this.results);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: Scaffold(
            body: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: GridView.count(
                controller: scrollController,
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: results.map((e) => ResultTile(e)).toList(),
              ),
            ),
          ),
        );
      },
      expand: false,
      maxChildSize: 1,
    );
  }
}
