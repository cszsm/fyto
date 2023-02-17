import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/identifier/result_selector/result_tile.dart';

class ResultSelector extends StatelessWidget {
  final List<Plant> results;

  const ResultSelector(this.results, {super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: Scaffold(
            body: Container(
              padding: const EdgeInsets.only(top: 20),
              color: colorScheme.surface,
              child: GridView.count(
                controller: scrollController,
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                padding: const EdgeInsets.all(12),
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
