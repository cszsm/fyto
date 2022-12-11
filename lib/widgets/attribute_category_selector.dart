import 'package:flutter/material.dart';
import 'package:fyto/data/plant_attribute_types.dart';
import 'package:fyto/widgets/attribute_category_tile.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: attributeTypes.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < attributeTypes.length) {
          final attribute = attributeTypes.elementAt(index);
          final attributeId = attribute['id'] as String;
          final selectedAttributeValueId = selection[attributeId];

          return Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? 400 : 0,
            ),
            child: AttributeCategoryTile(
              attributeId,
              selectedAttributeValueId,
              (newSelectedValueId) {
                setState(() {
                  if (newSelectedValueId == null) {
                    return;
                  }

                  if (selection[attributeId] == newSelectedValueId) {
                    selection.remove(attributeId);
                  } else {
                    selection[attributeId] = newSelectedValueId!;
                  }
                });

                widget.onSelectionChanged(selection);
              },
            ),
          );
        } else {
          return SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: selection.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_all),
                          onPressed: () {
                            selection.clear();
                            widget.onSelectionChanged(selection);
                          })
                      : Container(),
                ),
              )),
            ),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }
}
