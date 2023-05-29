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
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: results.map((e) => ResultTile(e)).toList(),
              ),
            ),
          ],
        );
      },
      expand: false,
    );
  }
}
