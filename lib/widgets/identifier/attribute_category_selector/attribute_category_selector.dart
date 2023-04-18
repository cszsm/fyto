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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final Map<String, String> selection = {};
  final List<String> defaultCategoryIds = getAttributeCategoryIds();
  List<String> unselectedCategoryIds = getAttributeCategoryIds();

  void select(categoryId, newSelectedValueId) {
    setState(() {
      if (newSelectedValueId == null) {
        return;
      }

      if (selection[categoryId] == newSelectedValueId) {
        int sIndex = selection.keys.toList().indexOf(categoryId);
        print(sIndex);

        selection.remove(categoryId);
        _listKey.currentState!.removeItem(
            sIndex,
            (context, animation) => FadeTransition(
                  opacity: CurvedAnimation(
                      parent: animation, curve: const Interval(0.5, 1.0)),
                  child: SizeTransition(
                    sizeFactor: CurvedAnimation(
                        parent: animation, curve: const Interval(0.0, 1.0)),
                    axisAlignment: 0.0,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: sIndex == 0 ? 400 : 8,
                        left: 10,
                        right: 10,
                      ),
                      child: SelectedCategoryTile(
                        categoryId: categoryId,
                        selectedValueId: newSelectedValueId ?? "",
                        onSelect: select,
                      ),
                    ),
                  ),
                ),
            duration: const Duration(seconds: 1));

        unselectedCategoryIds = List.from(defaultCategoryIds);
        unselectedCategoryIds
            .removeWhere((element) => selection.keys.contains(element));
        int uIndex =
            selection.length + unselectedCategoryIds.indexOf(categoryId);
        _listKey.currentState!
            .insertItem(uIndex, duration: const Duration(seconds: 1));
      } else {
        int index = unselectedCategoryIds.indexOf(categoryId);

        selection[categoryId] = newSelectedValueId;
        _listKey.currentState!.insertItem(selection.length - 1,
            duration: const Duration(seconds: 1));

        unselectedCategoryIds.remove(categoryId);
        _listKey.currentState!.removeItem(
            selection.length + index,
            (context, animation) => FadeTransition(
                opacity: CurvedAnimation(
                    parent: animation, curve: Interval(0.5, 1.0))),
            duration: const Duration(seconds: 1));
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

    return AnimatedList(
      shrinkWrap: true,
      key: _listKey,
      initialItemCount: itemCount + 1,
      itemBuilder:
          (BuildContext context, int index, Animation<double> animation) {
        print("aaaaaaa");
        print(index);
        print(resolveAttributeCategoryName(unselectedCategoryIds[index]));
        print("bbbbbbb");
        if (index == 0) {
          return SizedBox(
            height: 400,
          );
        } else if (index < selection.length + 1) {
          final categoryId = selection.keys.elementAt(index);
          final selectedValueId = selection[categoryId];

          return FadeTransition(
            opacity: animation,
            child: Padding(
              padding: EdgeInsets.only(
                top: 8,
                left: 10,
                right: 10,
              ),
              child: SelectedCategoryTile(
                categoryId: categoryId,
                selectedValueId: selectedValueId ?? "",
                onSelect: select,
              ),
            ),
          );
        } else if (selection.isNotEmpty && index == selection.length + 1) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 22),
                    child: selection.isNotEmpty
                        ? ClearFilterButton(
                            onTap: resetSelection,
                          )
                        : Container(),
                  ),
                ),
              ),
            ),
          );
        } else {
          print("else");
          print(resolveAttributeCategoryName(unselectedCategoryIds[index]));
          print(index);

          final unselectedIndex = selection.isNotEmpty
              ? index - selection.length - 2
              : index - selection.length - 1;
          final categoryId = unselectedCategoryIds.elementAt(unselectedIndex);

          return FadeTransition(
            opacity: animation,
            child: Padding(
              padding: EdgeInsets.only(
                top: 8,
                bottom: index - 1 == itemCount - 1 ? 90 : 0,
                left: 10,
                right: 10,
              ),
              child: UnselectedCategoryTile(
                categoryId: categoryId,
                onSelect: select,
              ),
            ),
          );
        }
      },
    );
  }
}
