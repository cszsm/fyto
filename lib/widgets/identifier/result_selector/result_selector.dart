import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/bottom_sheet_title.dart';
import 'package:fyto/widgets/drag_handle.dart';
import 'package:fyto/widgets/identifier/result_selector/result_tile.dart';

class ResultSelector extends StatelessWidget {
  final List<Plant> results;

  const ResultSelector(this.results, {super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DragHandle(),
            const BottomSheetTitle('Talált növények'),
            Expanded(
              child: GridView.count(
                controller: scrollController,
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                children: results.map((e) => ResultTile(e)).toList(),
              ),
            ),
          ],
        );
      },
      expand: false,
      maxChildSize: 0.9,
    );
  }
}
