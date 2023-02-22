import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyto/utils/utils.dart';

class AttributeValueTile extends StatelessWidget {
  final String valueId;
  final bool selected;

  const AttributeValueTile(this.valueId, this.selected, {super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final String attributeName = resolveAttributeValueName(valueId);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(valueId);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: selected ? colorScheme.secondaryContainer : Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    getPictogramPath(valueId),
                    color: selected
                        ? colorScheme.onSecondaryContainer
                        : colorScheme.onSurface,
                    placeholderBuilder: (context) => SizedBox(
                      height: 60,
                      child: Center(
                        child: Text(
                          'haló',
                          style: TextStyle(color: colorScheme.error),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                  "${attributeName[0].toUpperCase()}${attributeName.substring(1)}",
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
