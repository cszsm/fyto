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
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 3,
                child: FittedBox(
                  child: snapshot.data,
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    plant.name,
                    style:
                        TextStyle(color: colorScheme.onPrimary, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
