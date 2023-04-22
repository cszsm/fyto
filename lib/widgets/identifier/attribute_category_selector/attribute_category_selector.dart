import 'package:flutter/material.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/identifier/attribute_category_selector/selected_category_tile.dart';
import 'package:fyto/widgets/identifier/attribute_category_selector/tile_transition.dart';
import 'package:fyto/widgets/identifier/attribute_category_selector/unselected_category_tile.dart';
import 'package:fyto/widgets/identifier/clear_filter_button.dart';

const duration = Duration(milliseconds: 500);

class AttributeCategorySelector extends StatefulWidget {
  final Function onSelectionChanged;

  const AttributeCategorySelector(this.onSelectionChanged, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _AttributeCategorySelectorState();
  }
}

class _AttributeCategorySelectorState extends State<AttributeCategorySelector> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final Map<String, String> selection = {};
  final List<String> defaultCategoryIds = getAttributeCategoryIds();
  List<String> unselectedCategoryIds = getAttributeCategoryIds();

  void select(categoryId, newSelectedValueId) {
    setState(() {
      if (newSelectedValueId == null) {
        return;
      }

      String oldSelectedValueId = selection[categoryId] ?? "";

      if (oldSelectedValueId == "") {
        _addSelected(categoryId, newSelectedValueId);
        _removeUnselected(categoryId);
      } else if (oldSelectedValueId != newSelectedValueId) {
        selection[categoryId] = newSelectedValueId;
      } else {
        _removeSelected(categoryId, oldSelectedValueId);
        _addUnselected(categoryId);
      }
    });

    widget.onSelectionChanged(selection);
  }

  void _addSelected(categoryId, newSelectedValueId) {
    selection[categoryId] = newSelectedValueId;

    _listKey.currentState!.insertItem(
      selection.length,
      duration: duration,
    );

    if (selection.length == 1) {
      _addClearButton();
    }
  }

  void _removeSelected(categoryId, oldSelectedValueId) {
    int index = selection.keys.toList().indexOf(categoryId) + 1;

    selection.remove(categoryId);

    _listKey.currentState!.removeItem(
      index,
      duration: duration,
      (context, animation) => TileTransition(
        enter: false,
        animation: animation,
        child: _createSelectedTile(
          categoryId: categoryId,
          selectedValueId: oldSelectedValueId,
          onSelect: () {},
        ),
      ),
    );

    if (selection.isEmpty) {
      _removeClearButton();
    }
  }

  void _addClearButton() {
    int index = selection.length + 1;

    _listKey.currentState!.insertItem(
      index,
      duration: duration,
    );
  }

  void _removeClearButton() {
    int index = selection.length + 1;

    _listKey.currentState!.removeItem(
      index,
      duration: duration,
      (context, animation) => TileTransition(
        enter: false,
        animation: animation,
        child: _createClearButton(),
      ),
    );
  }

  void _addUnselected(categoryId) {
    unselectedCategoryIds = List.from(defaultCategoryIds);
    unselectedCategoryIds
        .removeWhere((element) => selection.keys.contains(element));

    int index = selection.isNotEmpty
        ? unselectedCategoryIds.indexOf(categoryId) + selection.length + 2
        : unselectedCategoryIds.indexOf(categoryId) + 1;

    _listKey.currentState!.insertItem(
      index,
      duration: duration,
    );
  }

  void _removeUnselected(categoryId) {
    int index = selection.isNotEmpty
        ? unselectedCategoryIds.indexOf(categoryId) + selection.length + 2
        : unselectedCategoryIds.indexOf(categoryId) + 1;

    unselectedCategoryIds.remove(categoryId);

    _listKey.currentState!.removeItem(
      index,
      duration: duration,
      (context, animation) => TileTransition(
        enter: false,
        animation: animation,
        child: _createUnselectedTile(
          categoryId: categoryId,
          onSelect: () {},
        ),
      ),
    );
  }

  void resetSelection() {
    setState(() {
      for (var element in selection.entries) {
        int index = 1;
        _listKey.currentState!.removeItem(
          index,
          duration: duration,
          (context, animation) => TileTransition(
            enter: false,
            animation: animation,
            child: _createSelectedTile(
              categoryId: element.key,
              selectedValueId: element.value,
              onSelect: () {},
            ),
          ),
        );
      }

      var entries = selection.entries.toList();
      selection.clear();
      _removeClearButton();

      unselectedCategoryIds = List.from(defaultCategoryIds);
      for (var element in entries) {
        int index = unselectedCategoryIds.indexOf(element.key) + 1;
        _listKey.currentState!.insertItem(
          index,
          duration: duration,
        );
      }

      widget.onSelectionChanged(selection);
    });
  }

  @override
  Widget build(BuildContext context) {
    int initialItemCount = unselectedCategoryIds.length + 2;

    return AnimatedList(
        key: _listKey,
        initialItemCount: initialItemCount,
        itemBuilder: (context, index, animation) {
          if (index == 0) {
            return _createTopSpace();
          }

          if (index <= selection.length) {
            final selectedIndex = index - 1;
            final categoryId = selection.keys.elementAt(selectedIndex);

            return TileTransition(
              enter: true,
              animation: animation,
              child: _createSelectedTile(
                categoryId: categoryId,
                selectedValueId: selection[categoryId] ?? "",
                onSelect: select,
              ),
            );
          }

          if (selection.isNotEmpty && index == selection.length + 1) {
            return TileTransition(
              enter: true,
              animation: animation,
              child: _createClearButton(),
            );
          }

          if ((selection.isNotEmpty && index < defaultCategoryIds.length + 2) ||
              (selection.isEmpty && index < defaultCategoryIds.length + 1)) {
            final unselectedIndex =
                selection.isNotEmpty ? index - selection.length - 2 : index - 1;
            final categoryId = unselectedCategoryIds.elementAt(unselectedIndex);

            return TileTransition(
              enter: true,
              animation: animation,
              child: _createUnselectedTile(
                categoryId: categoryId,
                onSelect: select,
              ),
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
