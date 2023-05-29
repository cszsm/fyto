import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/identifier/plant_details/plant_details.dart';
import 'package:path_provider/path_provider.dart';

class ResultTile extends StatelessWidget {
  final Plant plant;

  const ResultTile(this.plant, {super.key});

  Future<Image?> _getImage() async {
    final Directory applicationDirectory =
        await getApplicationDocumentsDirectory();
    final String plantDirectoryName =
        plant.latinName.toLowerCase().replaceAll(' ', '_');
    final String plantDirectoryPath =
        '${applicationDirectory.path}/images/plants/$plantDirectoryName';
    final Directory plantDirectory = Directory(plantDirectoryPath);
    try {
      final File plantImage = (await plantDirectory.list().first) as File;
      return Image.file(plantImage);
    } catch (e) {
      return Image.asset('assets/images/missing.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder(
      future: _getImage(),
      builder: (context, AsyncSnapshot<Image?> snapshot) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PlantDetails(plant)));
          },
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: colorScheme.secondaryContainer,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        clipBehavior: Clip.hardEdge,
                        child: snapshot.data,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        plant.name,
                        style: TextStyle(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
