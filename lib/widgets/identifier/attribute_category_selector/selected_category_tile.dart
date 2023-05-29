import 'package:flutter/material.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/identifier/attribute_category_selector/category_tile.dart';
import 'package:fyto/widgets/identifier/attribute_category_selector/category_tile_icon.dart';
import 'package:fyto/widgets/identifier/attribute_value_selector/attribute_value_selector.dart';

class SelectedCategoryTile extends StatelessWidget {
  final String categoryId;
  final String selectedValueId;
  final Function onSelect;

  final String categoryName;
  final String selectedValueName;

  SelectedCategoryTile({
    super.key,
    required this.categoryId,
    required this.selectedValueId,
    required this.onSelect,
  })  : categoryName = resolveAttributeCategoryName(categoryId),
        selectedValueName = resolveAttributeValueName(selectedValueId);

  void openValueSelector(BuildContext context) async {
    var result = await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return AttributeValueSelector(categoryId, selectedValueId);
      },
    );
    onSelect(categoryId, result);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool colored = ['22', '32'].contains(categoryId);

    return CategoryTile(
      icon: categoryTileIcon(
        path: getPictogramPath(selectedValueId),
        color: colored ? null : colorScheme.onSurface,
        errorColor: colorScheme.error,
      ),
      onSelect: openValueSelector,
      onClose: () => onSelect(categoryId, selectedValueId),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            capitalizeFirstLetter(categoryName),
            style: TextStyle(
              color: colorScheme.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            capitalizeFirstLetter(selectedValueName),
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
