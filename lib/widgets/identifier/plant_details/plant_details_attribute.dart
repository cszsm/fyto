import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyto/utils/utils.dart';

class PlantDetailsAttribute extends StatelessWidget {
  final String valueId;
  final String categoryName;
  final String valueName;

  PlantDetailsAttribute(categoryId, this.valueId, {super.key})
      : categoryName = resolveAttributeCategoryName(categoryId),
        valueName = resolveAttributeValueName(valueId);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: colorScheme.tertiaryContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SvgPicture.asset(
                  getPictogramPath(valueId),
                  width: 32,
                  height: 32,
                  color: colorScheme.onTertiaryContainer,
                  placeholderBuilder: (context) => SizedBox(
                    width: 32,
                    height: 32,
                    child: Center(
                      child: Text(
                        'haló',
                        style: TextStyle(color: colorScheme.error),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    capitalizeFirstLetter(categoryName),
                    style: TextStyle(
                      color: colorScheme.onTertiaryContainer,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    capitalizeFirstLetter(valueName),
                    style: TextStyle(
                      color: colorScheme.tertiary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
