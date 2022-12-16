import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyto/data/plant_attribute_types.dart';
import 'package:fyto/data/plant_attribute_values.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/attribute_value_selector/attribute_value_selector.dart';

class AttributeCategoryTile extends StatelessWidget {
  String categoryId;
  String? selectedValueId;
  Function onSelect;

  String categoryName;
  String? selectedValueName;

  AttributeCategoryTile(
    this.categoryId,
    this.selectedValueId,
    this.onSelect,
  )   : categoryName = attributeTypes.firstWhere(
            (e) => (e['id'] as String) == categoryId)['name'] as String,
        selectedValueName = selectedValueId != null
            ? attributeValues.firstWhere(
                (e) => (e['id'] as String) == selectedValueId)['name'] as String
            : null;

  void openValueSelector(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) {
        return AttributeValueSelector(categoryId, selectedValueId);
      },
    );
    onSelect(categoryId, result);
  }

  Widget selectedCategory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(capitalizeFirstLetter(categoryName),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
            )),
        Text(capitalizeFirstLetter(selectedValueName!),
            style: TextStyle(
              color: Colors.green[600],
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ))
      ],
    );
  }

  Widget unselectedCategory() {
    return Text(capitalizeFirstLetter(categoryName),
        style: const TextStyle(
          fontWeight: FontWeight.w300,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openValueSelector(context),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: selectedValueId != null ? Colors.white : Colors.grey[200]!,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                  selectedValueId != null
                      ? getPictogramPath(selectedValueId)
                      : '',
                  width: 40,
                  height: 40,
                  color: selectedValueId != null
                      ? Colors.green[600]
                      : Colors.black,
                  placeholderBuilder: (context) => const SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                          child: Text(
                        'haló',
                        style: TextStyle(color: Colors.red),
                      )))),
            ),
            Expanded(
                child: selectedValueId != null
                    ? selectedCategory()
                    : unselectedCategory()),
            selectedValueId != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: IconButton(
                      onPressed: () => onSelect(categoryId, selectedValueId),
                      icon: const Icon(Icons.clear),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
