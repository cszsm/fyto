import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/identifier/result_selector/result_tile.dart';

class ResultSelector extends StatelessWidget {
  final List<Plant> results;

  const ResultSelector(this.results, {super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Column(
          children: [
            const SizedBox(
              height: 48,
              child: Icon(Icons.horizontal_rule),
            ),
            Expanded(
              child: GridView.count(
                controller: scrollController,
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                padding: const EdgeInsets.all(4),
                children: results.map((e) => ResultTile(e)).toList(),
              ),
            ),
          ],
        );
      },
      expand: false,
      maxChildSize: 0.8,
    );
  }
}
