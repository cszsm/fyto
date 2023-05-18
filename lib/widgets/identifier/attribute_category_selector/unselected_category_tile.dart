import 'package:flutter/material.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/identifier/attribute_category_selector/category_tile.dart';
import 'package:fyto/widgets/identifier/attribute_category_selector/category_tile_icon.dart';
import 'package:fyto/widgets/identifier/attribute_value_selector/attribute_value_selector.dart';

class UnselectedCategoryTile extends StatelessWidget {
  final String categoryId;
  final Function onSelect;

  final String categoryName;

  UnselectedCategoryTile({
    super.key,
    required this.categoryId,
    required this.onSelect,
  }) : categoryName = resolveAttributeCategoryName(categoryId);

  void openValueSelector(BuildContext context) async {
    var result = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return AttributeValueSelector(categoryId, null);
      },
      isScrollControlled: true,
    );
    onSelect(categoryId, result);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return CategoryTile(
      backgroundColor: colorScheme.surfaceVariant.withOpacity(0.8),
      icon: categoryTileIcon(
        path: getAttributeCategoryPictogramPath(categoryId),
        color: colorScheme.onSurfaceVariant,
        errorColor: colorScheme.error,
      ),
      onSelect: openValueSelector,
      child: Text(
        capitalizeFirstLetter(categoryName),
        style: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
