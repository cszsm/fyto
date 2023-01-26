import 'package:fyto/data/plant_attribute_types.dart';
import 'package:fyto/data/plant_attribute_values.dart';
import 'package:fyto/data/plant_attributes.dart';
import 'package:fyto/models/plant.dart';

String _resolve(String id, List<Map<String, Object>> values) {
  return values.firstWhere((element) => element['id'] == id)['name'] as String;
}

String resolveAttributeTypeName(String typeId) =>
    _resolve(typeId, attributeTypes);
String resolveAttributeValueName(String valueId) =>
    _resolve(valueId, attributeValues);

List<String> resolveAttributeValues(String typeId) {
  return plantAttributes.firstWhere(
      (element) => (element['type']) == typeId)['attributes'] as List<String>;
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

String getPictogramPath(valueId) {
  final String typeName =
      resolveAttributeTypeName(valueId.substring(0, 2)).replaceAll(' ', '_');
  final String attributeName = resolveAttributeValueName(valueId)
      .replaceAll(' ', '_')
      .replaceAll('*', '');
  return deaccentize(
      'assets/images/pictograms/$typeName/${typeName}_$attributeName.svg');
}
