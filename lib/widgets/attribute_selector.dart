import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyto/data/plant_attribute_types.dart';
import 'package:fyto/data/plant_attribute_values.dart';
import 'package:fyto/widgets/attribute_dialog.dart';

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

  List<ElevatedButton> createAttributeButtons(BuildContext context) {
    return attributeTypes.map(
      (attribute) {
        final List<Widget> children = [Text(attribute['name'] as String)];
        final attributeId = attribute['id'] as String;
        final a2Id = selection[attributeId];
        if (a2Id != null) {
          final attribute2 = attributeValues
              .firstWhere((e) => (e['id'] as String) == a2Id)['name'] as String;
          children.add(Text(attribute2));
        }
        children.add(SvgPicture.asset(
          'assets/images/viragzat_kunkor.svg',
          width: 50,
          height: 50,
        ));

        return ElevatedButton(
          onPressed: () async {
            var result = await showDialog(
              context: context,
              builder: (context) {
                return AttributeDialog(attribute['id'] as String);
              },
            );

            setState(() {
              if (selection[attributeId] == result) {
                selection.remove(attributeId);
              } else {
                selection[attributeId] = result;
              }
            });

            widget.onSelectionChanged(selection);
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
