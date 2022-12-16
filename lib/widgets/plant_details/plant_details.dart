import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/plant_details/image_grid.dart';
import 'package:fyto/widgets/plant_details/plant_details_attribute.dart';
import 'package:fyto/widgets/plant_details/plant_details_description.dart';
import 'package:fyto/widgets/plant_details/plant_details_header.dart';
import 'package:path_provider/path_provider.dart';

enum Page {
  description,
  attributes,
}

class PlantDetails extends StatefulWidget {
  final Plant plant;

  const PlantDetails(this.plant, {super.key});

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  Page selectedPage = Page.description;

  Future<Image?> _getImage() async {
    final Directory applicationDirectory =
        await getApplicationDocumentsDirectory();
    final String plantDirectoryName =
        widget.plant.latinName.toLowerCase().replaceAll(' ', '_');
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
    final Map<String, String> attributes = widget.plant.attributes;

    return FutureBuilder(
      future: _getImage(),
      builder: (context, AsyncSnapshot<Image?> snapshot) => Scaffold(
        backgroundColor: colorScheme.background,
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 12),
              child:
                  PlantDetailsHeader(widget.plant.name, widget.plant.latinName),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ImageGrid(widget.plant.latinName),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PlantDetailsDescription(widget.plant.description),
            ),
            ...List.generate(attributes.entries.length, (index) {
              MapEntry attribute = attributes.entries.elementAt(index);

              return Padding(
                padding: EdgeInsets.only(
                    bottom: index != attributes.entries.length ? 12 : 0),
                child: PlantDetailsAttribute(attribute.key, attribute.value),
              );
            })
          ],
        ),
      ),
    );
  }
}
