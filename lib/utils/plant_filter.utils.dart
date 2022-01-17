import 'package:fyto/models/plant.dart';

List<Plant> filterPlants(PlantAttributes criteria, List<Plant> plants) {
  return plants.where((plant) => plant.isFit(criteria)).toList();
}
