import 'package:fyto/data/plant_attribute_categories.dart';
import 'package:fyto/data/plant_attribute_values.dart';
import 'package:fyto/data/plant_attributes.dart';
import 'package:fyto/models/plant.dart';

List<String> getAttributeCategoryIds() {
  return attributeCategories.map((category) => category['id'] as String).toList();
}

String _resolve(String id, List<Map<String, Object>> values) {
  return values.firstWhere((element) => element['id'] == id)['name'] as String;
}

String resolveAttributeCategoryName(String categoryId) =>
    _resolve(categoryId, attributeCategories);
String resolveAttributeValueName(String valueId) =>
    _resolve(valueId, attributeValues);

List<String> resolveAttributeValues(String categoryId) {
  return plantAttributes.firstWhere(
      (element) => (element['type']) == categoryId)['attributes'] as List<String>;
}

List<Plant> filterPlants(PlantAttributes criteria, List<Plant> plants) {
  return plants.where((plant) => plant.isFit(criteria)).toList();
}

String capitalizeFirstLetter(String s) =>
    "${s[0].toUpperCase()}${s.substring(1)}";

String deaccentize(String s) {
  return s
      .replaceAll('á', 'a')
      .replaceAll('é', 'e')
      .replaceAll('í', 'i')
      .replaceAll(RegExp('[óöő]'), 'o')
      .replaceAll(RegExp('[úüű]'), 'u');
}

String getAttributeCategoryPictogramPath(categoryId) {
  final String categoryName = resolveAttributeCategoryName(categoryId)
      .replaceAll(' ', '_')
      .replaceAll('*', '');
  return deaccentize('assets/images/pictograms/kategoria/$categoryName.svg');
}

String getPictogramPath(valueId) {
  final String categoryName =
      resolveAttributeCategoryName(valueId.substring(0, 2))
      .replaceAll(' ', '_');
  final String attributeName = resolveAttributeValueName(valueId)
      .replaceAll(' ', '_')
      .replaceAll('*', '');
  return deaccentize(
      'assets/images/pictograms/$categoryName/${categoryName}_$attributeName.svg');
}
