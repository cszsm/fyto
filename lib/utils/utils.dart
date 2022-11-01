import 'package:fyto/data/plant_attribute_types.dart';
import 'package:fyto/data/plant_attribute_values.dart';
import 'package:fyto/models/plant.dart';

String _resolve(String id, List<Map<String, Object>> values) {
  return values.firstWhere((element) => element['id'] == id)['name'] as String;
}

String resolveAttributeType(String id) => _resolve(id, attributeTypes);
String resolveAttributeValue(String id) => _resolve(id, attributeValues);

List<Plant> filterPlants(PlantAttributes criteria, List<Plant> plants) {
  return plants.where((plant) => plant.isFit(criteria)).toList();
}

String capitalizeFirstLetter(String s) => "${s[0].toUpperCase()}${s.substring(1)}";
