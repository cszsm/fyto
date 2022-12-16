import 'package:flutter/material.dart';
import 'package:fyto/data/plant_attribute_types.dart';
import 'package:fyto/widgets/attribute_category_selector/attribute_category_tile.dart';

// TODO: check if this should really be stateful
class AttributeSelector extends StatefulWidget {
  final Function onSelectionChanged;

  const AttributeSelector(this.onSelectionChanged);

  @override
  State<StatefulWidget> createState() {
    return _AttributeSelectorState();
  }
}

class _AttributeSelectorState extends State<AttributeSelector> {
  final Map<String, String> selection = {};

  void select(categoryId, newSelectedValueId) {
    setState(() {
      if (newSelectedValueId == null) {
        return;
      }

      if (selection[categoryId] == newSelectedValueId) {
        selection.remove(categoryId);
      } else {
        selection[categoryId] = newSelectedValueId!;
      }
    });

    widget.onSelectionChanged(selection);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 10);
      },
      itemCount: attributeTypes.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < attributeTypes.length) {
          final categoryId = attributeTypes.elementAt(index)['id'] as String;
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
        } else {
          return SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: selection.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.playlist_remove),
                          onPressed: () {
                            selection.clear();
                            widget.onSelectionChanged(selection);
                          })
                      : Container(),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
