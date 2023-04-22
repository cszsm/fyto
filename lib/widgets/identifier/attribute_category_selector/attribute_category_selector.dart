import 'package:flutter/material.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/identifier/attribute_category_selector/selected_category_tile.dart';
import 'package:fyto/widgets/identifier/attribute_category_selector/unselected_category_tile.dart';
import 'package:fyto/widgets/identifier/clear_filter_button.dart';

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
  final List<String> defaultCategoryIds = getAttributeCategoryIds();
  List<String> unselectedCategoryIds = getAttributeCategoryIds();

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
    itemCount = selection.isNotEmpty ? itemCount + 3 : itemCount + 2;

    return ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _createTopSpace();
          }

          if (index <= selection.length) {
            final selectedIndex = index - 1;
            final categoryId = selection.keys.elementAt(selectedIndex);
            return _createSelectedTile(
              categoryId: categoryId,
              selectedValueId: selection[categoryId] ?? "",
              onSelect: select,
            );
          }

          if (selection.isNotEmpty && index == selection.length + 1) {
            return _createClearButton();
          }

          if ((selection.isNotEmpty && index < defaultCategoryIds.length + 2) ||
              (selection.isEmpty && index < defaultCategoryIds.length + 1)) {
            final unselectedIndex =
                selection.isNotEmpty ? index - selection.length - 2 : index - 1;
            final categoryId = unselectedCategoryIds.elementAt(unselectedIndex);
            return _createUnselectedTile(
              categoryId: categoryId,
              onSelect: select,
            );
          }

          return _createBottomSpace();
        });
  }

  Widget _createTopSpace() {
    return const SizedBox(
      height: 400,
    );
  }

  Widget _createSelectedTile({
    required String categoryId,
    required String selectedValueId,
    required Function onSelect,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
      child: SelectedCategoryTile(
        categoryId: categoryId,
        selectedValueId: selectedValueId,
        onSelect: onSelect,
      ),
    );
  }

  Widget _createClearButton() {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 22),
            child: ClearFilterButton(
              onTap: resetSelection,
            ),
          ),
        ),
      ),
    );
  }

  Widget _createUnselectedTile({
    required String categoryId,
    required Function onSelect,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
      child: UnselectedCategoryTile(
        categoryId: categoryId,
        onSelect: onSelect,
      ),
    );
  }

  Widget _createBottomSpace() {
    return const SizedBox(
      height: 90,
    );
  }
}
