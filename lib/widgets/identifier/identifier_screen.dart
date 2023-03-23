import 'package:flutter/material.dart';
import 'package:fyto/data/plants.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/identifier/attribute_category_selector/attribute_category_selector.dart';
import 'package:fyto/widgets/identifier/parallax_image.dart';
import 'package:fyto/widgets/identifier/plant_details/plant_details.dart';
import 'package:fyto/widgets/identifier/result_selector/result_selector.dart';

class IdentifierScreen extends StatefulWidget {
  const IdentifierScreen({super.key});

  @override
  State<IdentifierScreen> createState() => _IdentifierScreenState();
}

class _IdentifierScreenState extends State<IdentifierScreen> {
  List<Plant> foundPlants = [];
  String text = 'Válasszon jellemzőt';
  bool isPlantFound = false;
  bool fabEnabled = false;

  double pos = 0;

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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final avaliableHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            setState(() {
              pos -= (notification.scrollDelta ?? 0);
            });
          }
          return true;
        },
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double listHeight = constraints.maxHeight;
                return Stack(
                  children: [
                    ParallaxImage(
                      imagePath: 'assets/images/backgrounds/background1.png',
                      scrollDelta: pos,
                      parentHeight: listHeight,
                      avaliableHeight: avaliableHeight,
                      parallaxNumber: 4,
                    ),
                    ParallaxImage(
                      imagePath: 'assets/images/backgrounds/background2.png',
                      scrollDelta: pos,
                      parentHeight: listHeight,
                      avaliableHeight: avaliableHeight,
                      parallaxNumber: 3,
                    ),
                    ParallaxImage(
                      imagePath: 'assets/images/backgrounds/background3.png',
                      scrollDelta: pos,
                      parentHeight: listHeight,
                      avaliableHeight: avaliableHeight,
                      parallaxNumber: 2,
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: AttributeCategorySelector(_filterPlants),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: fabEnabled
            ? (isPlantFound
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetails(foundPlants[0]),
                      ),
                    );
                  }
                : () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ResultSelector(foundPlants);
                      },
                      isScrollControlled: true,
                    );
                  })
            : null,
        label: Text(text),
        backgroundColor: fabEnabled
            ? colorScheme.primaryContainer
            : colorScheme.secondaryContainer,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
