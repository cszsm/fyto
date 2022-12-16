import 'package:flutter/material.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/attribute_value_selector/attribute_value_tile.dart';

class AttributeValueSelector extends StatelessWidget {
  final String attributeCategoryId;
  final String? selectedAttributeValueId;

  const AttributeValueSelector(
      this.attributeCategoryId, this.selectedAttributeValueId,
      {super.key});

  List<AttributeValueTile> createAttributeValueTiles(context) {
    final attributes = resolveAttributeValues(attributeCategoryId);
    return attributes.map((attribute) {
      return AttributeValueTile(
          attribute, selectedAttributeValueId == attribute);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: Container(
            color: colorScheme.surface,
            child: GridView.count(
              controller: scrollController,
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
              padding: const EdgeInsets.all(20),
              children: createAttributeValueTiles(context),
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
