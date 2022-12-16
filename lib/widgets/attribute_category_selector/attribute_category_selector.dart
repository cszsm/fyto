import 'package:flutter/material.dart';
import 'package:fyto/data/plant_attribute_types.dart';
import 'package:fyto/widgets/attribute_category_selector/attribute_category_tile.dart';

// TODO: check if this should really be stateful
class AttributeCategorySelector extends StatefulWidget {
  final Function onSelectionChanged;

  const AttributeCategorySelector(this.onSelectionChanged, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _AttributeCategorySelectorState();
  }
}

class _AttributeCategorySelectorState extends State<AttributeCategorySelector> {
  final Map<String, String> selection = {};
  final List<String> defaultCategoryIds =
      attributeTypes.map((category) => category['id'] as String).toList();
  // TODO: resolve this duplication
  List<String> unselectedCategoryIds =
      attributeTypes.map((category) => category['id'] as String).toList();

  void select(categoryId, newSelectedValueId) {
    setState(() {
      if (newSelectedValueId == null) {
        return;
      }

      if (selection[categoryId] == newSelectedValueId) {
        selection.remove(categoryId);
        unselectedCategoryIds = List.from(defaultCategoryIds);
        unselectedCategoryIds
            .removeWhere((element) => selection.keys.contains(element));
      } else {
        selection[categoryId] = newSelectedValueId;
        unselectedCategoryIds.remove(categoryId);
      }
    });

    widget.onSelectionChanged(selection);
  }

  void resetSelection() {
    setState(() {
      selection.clear();
      unselectedCategoryIds = List.from(defaultCategoryIds);
      widget.onSelectionChanged(selection);
    });
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = selection.length + unselectedCategoryIds.length;
    itemCount = selection.isNotEmpty ? itemCount + 1 : itemCount;

    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 4);
      },
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        if (index < selection.length) {
          final categoryId = selection.keys.elementAt(index);
          final selectedValueId = selection[categoryId];

          return Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? 400 : 0,
            ),
            child: AttributeCategoryTile(
              categoryId,
              selectedValueId,
              select,
            ),
          );
        } else if (selection.isNotEmpty && index == selection.length) {
          return SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: selection.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.playlist_remove,
                            size: 28,
                          ),
                          onPressed: resetSelection)
                      : Container(),
                ),
              ),
            ),
          );
        } else {
          final unselectedIndex = selection.isNotEmpty
              ? index - selection.length - 1
              : index - selection.length;
          final categoryId = unselectedCategoryIds.elementAt(unselectedIndex);

          return Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? 400 : 0,
              bottom: index == itemCount - 1 ? 90 : 0,
            ),
            child: AttributeCategoryTile(
              categoryId,
              null,
              select,
            ),
          );
        }
      },
    );
  }
}
