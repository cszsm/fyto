import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/identifier/plant_details/image_grid.dart';
import 'package:fyto/widgets/identifier/plant_details/plant_details_attribute.dart';
import 'package:fyto/widgets/identifier/plant_details/plant_details_description.dart';
import 'package:fyto/widgets/identifier/plant_details/plant_details_header.dart';
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

  Future<List<Image>> _getImages(latinName) async {
    final Directory applicationDirectory =
        await getApplicationDocumentsDirectory();
    final String plantDirectoryName =
        latinName.toLowerCase().replaceAll(' ', '_');
    final String plantDirectoryPath =
        '${applicationDirectory.path}/images/plants/$plantDirectoryName';
    final Directory plantDirectory = Directory(plantDirectoryPath);
    try {
      final List<Image> images = await plantDirectory.list().map((filePath) {
        return Image.file(filePath as File);
      }).toList();
      return images;
    } catch (e) {
      return [];
    }
  }

  List<Widget> _getElements(List<Image> images) {
    final Map<String, String> attributes = widget.plant.attributes;

    List<Widget> elements = [
      Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 12),
        child: PlantDetailsHeader(widget.plant.name, widget.plant.latinName),
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
    ];

    if (images.isNotEmpty) {
      elements.insert(
        1,
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ImageGrid(images),
        ),
      );
    }

    return elements;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder(
      future: _getImages(widget.plant.latinName),
      builder: (context, AsyncSnapshot<List<Image>> snapshot) => Scaffold(
        backgroundColor: colorScheme.background,
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: snapshot.data != null ? _getElements(snapshot.data!) : [],
        ),
      ),
    );
  }
}
