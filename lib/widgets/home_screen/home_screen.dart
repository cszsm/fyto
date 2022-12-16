import 'package:flutter/material.dart';
import 'package:fyto/data/plants.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/attribute_category_selector/attribute_category_selector.dart';
import 'package:fyto/widgets/plant_details/plant_details.dart';
import 'package:fyto/widgets/result_selector/result_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Plant> foundPlants = [];
  String text = 'Válasszon jellemzőt';
  bool isPlantFound = false;
  bool fabEnabled = false;

  void _filterPlants(Map<String, String> selection) {
    final criteria = PlantAttributes(selection);
    final p = plants.map((e) => Plant.fromRaw(e)).toList();
    foundPlants = filterPlants(criteria, p);
    setState(() {
      if (selection.isEmpty) {
        text = 'Válasszon jellemzőt';
        isPlantFound = false;
        fabEnabled = false;
      } else if (foundPlants.length > 1) {
        text = '${foundPlants.length} talált növény';
        isPlantFound = false;
        fabEnabled = true;
      } else if (foundPlants.length == 1) {
        text = foundPlants[0].name;
        isPlantFound = true;
        fabEnabled = true;
      } else {
        text = 'Nincs ilyen növény';
        isPlantFound = false;
        fabEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableHeigth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: AttributeSelector(_filterPlants),
        ),
        height: availableHeigth,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: fabEnabled
            ? (isPlantFound
                ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PlantDetails(foundPlants[0])));
                  }
                : () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ResultSelector(foundPlants);
                        });
                  })
            : null,
        label: Text(
          text,
          style: TextStyle(
            color: fabEnabled ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: fabEnabled ? Colors.green : Colors.grey[100],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
