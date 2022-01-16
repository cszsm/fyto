import 'package:flutter/material.dart';
import 'package:fyto/data/plant_attributes.dart';
import 'package:fyto/widgets/attribute_dialog.dart';

class AttributeSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AttributeSelectorState();
  }
}

class _AttributeSelectorState extends State<AttributeSelector> {
  final Map<String, String> selection = {};

  List<ElevatedButton> createAttributeButtons(BuildContext context) {
    return plantAttributes.map(
      (attribute) {
        final children = [Text(attribute)];
        final value = selection[attribute];
        if (value != null) {
          children.add(Text(value));
        }
        return ElevatedButton(
          onPressed: () async {
            var result = await showDialog(
              context: context,
              builder: (context) {
                return AttributeDialog();
              },
            );

            setState(() {
              if (selection[attribute] == result) {
                selection.remove(attribute);
              } else {
                selection[attribute] = result;
              }
            });
          },
          child: Column(
            children: children,
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 3,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: createAttributeButtons(context),
    );
  }
}
