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
    return FutureBuilder(
      future: _getImage(),
      builder: (context, AsyncSnapshot<Image?> snapshot) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PlantDetails(plant)));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
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
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 4,
                  child: SizedBox(
                    child: Text(
                      plant.name,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
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
