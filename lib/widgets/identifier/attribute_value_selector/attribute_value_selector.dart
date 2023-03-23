import 'package:flutter/material.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/bottom_sheet_title.dart';
import 'package:fyto/widgets/drag_handle.dart';
import 'package:fyto/widgets/identifier/attribute_value_selector/attribute_value_tile.dart';

class AttributeValueSelector extends StatelessWidget {
  final String attributeCategoryId;
  final String? selectedAttributeValueId;

  const AttributeValueSelector(
      this.attributeCategoryId, this.selectedAttributeValueId,
      {super.key});

  List<AttributeValueTile> createAttributeValueTiles(context) {
    final attributeIds = resolveAttributeValues(attributeCategoryId);
    return attributeIds.map((attributeId) {
      return AttributeValueTile(
          attributeId, selectedAttributeValueId == attributeId, ['22', '32'].contains(attributeCategoryId));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final categoryName = capitalizeFirstLetter(
        resolveAttributeCategoryName(attributeCategoryId));

    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DragHandle(),
            BottomSheetTitle(categoryName),
            Expanded(
              child: GridView.count(
                controller: scrollController,
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 1,
                padding: const EdgeInsets.all(4),
                children: createAttributeValueTiles(context),
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
