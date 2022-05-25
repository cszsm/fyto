import 'dart:math';

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
    return ListView.separated(
      itemCount: attributeTypes.length,
      itemBuilder: (BuildContext context, int index) {
        final attribute = attributeTypes.elementAt(index);
        final attributeName = attribute['name']!;
        final attributeId = attribute['id'] as String;
        final valueId = selection[attributeId];

        Widget right;
        if (valueId != null) {
          final valueName = attributeValues.firstWhere(
              (e) => (e['id'] as String) == valueId)['name'] as String;
          right = Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${attributeName[0].toUpperCase()}${attributeName.substring(1)}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "${valueName[0].toUpperCase()}${valueName.substring(1)}",
                style: TextStyle(
                  color: Colors.green[600],
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          );
        } else {
          right = Text(
            "${attributeName[0].toUpperCase()}${attributeName.substring(1)}",
            style: const TextStyle(
              fontWeight: FontWeight.w300,
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 400 : 0,
            bottom: index == attributeTypes.length - 1 ? 80 : 0,
          ),
          child: GestureDetector(
            onTap: () async {
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
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: valueId != null ? Colors.white : Colors.grey[200]!,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                    blurStyle: BlurStyle.normal,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SvgPicture.asset(
                      'assets/images/viragzat_kunkor.svg',
                      width: 40,
                      height: 40,
                      color: valueId != null ? Colors.green[600] : Colors.black,
                    ),
                  ),
                  right
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }
}
