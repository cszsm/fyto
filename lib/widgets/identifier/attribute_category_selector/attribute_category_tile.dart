import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/identifier/attribute_value_selector/attribute_value_selector.dart';

class AttributeCategoryTile extends StatelessWidget {
  final String categoryId;
  final String? selectedValueId;
  final Function onSelect;

  final String categoryName;
  final String? selectedValueName;

  AttributeCategoryTile(this.categoryId, this.selectedValueId, this.onSelect,
      {super.key})
      : categoryName = resolveAttributeTypeName(categoryId),
        selectedValueName = selectedValueId != null
            ? resolveAttributeValueName(selectedValueId)
            : null;

  void openValueSelector(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) {
        return AttributeValueSelector(categoryId, selectedValueId);
      },
    );
    onSelect(categoryId, result);
  }

  Widget selectedCategory(ColorScheme colorScheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          capitalizeFirstLetter(categoryName),
          style: TextStyle(
            color: colorScheme.onSecondaryContainer,
            fontSize: 14,
          ),
        ),
        Text(
          capitalizeFirstLetter(selectedValueName!),
          style: TextStyle(
            color: colorScheme.secondary,
            fontSize: 20,
          ),
        )
      ],
    );
  }

  Widget unselectedCategory(ColorScheme colorScheme) {
    return Text(
      capitalizeFirstLetter(categoryName),
      style: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 14,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => openValueSelector(context),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: selectedValueId != null
                  ? colorScheme.secondaryContainer
                  : colorScheme.surfaceVariant.withOpacity(0.7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SvgPicture.asset(
                      selectedValueId != null
                          ? getPictogramPath(selectedValueId)
                          : '',
                      width: 32,
                      height: 32,
                      color: selectedValueId != null
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                      placeholderBuilder: (context) => SizedBox(
                        width: 32,
                        height: 32,
                        child: Center(
                          child: Text(
                            'haló',
                            style: TextStyle(color: colorScheme.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: selectedValueId != null
                        ? selectedCategory(colorScheme)
                        : unselectedCategory(colorScheme),
                  ),
                  selectedValueId != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: IconButton(
                            onPressed: () =>
                                onSelect(categoryId, selectedValueId),
                            icon: const Icon(
                              Icons.clear,
                              size: 28,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
