import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyto/utils/utils.dart';

class AttributeValueTile extends StatelessWidget {
  final String valueId;
  final bool selected;
  final bool colored;

  AttributeValueTile(this.valueId, this.selected, this.colored, {super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final String attributeName = resolveAttributeValueName(valueId);

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Material(
        color: selected ? colorScheme.secondaryContainer : Colors.transparent,
        child: InkWell(
          splashColor: selected ? colorScheme.surface : colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(28),
          onTap: () {
            Navigator.of(context).pop(valueId);
          },
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
                    colorFilter: colored
                        ? null
                        : ColorFilter.mode(
                            selected
                                ? colorScheme.onSecondaryContainer
                                : colorScheme.onSurface,
                            BlendMode.srcIn,
                          ),
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
