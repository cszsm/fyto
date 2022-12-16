import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/result_selector/result_tile.dart';

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
              padding: const EdgeInsets.only(top: 20),
              color: Colors.white,
              child: GridView.count(
                controller: scrollController,
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                children: results.map((e) => ResultTile(e)).toList(),
              ),
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
