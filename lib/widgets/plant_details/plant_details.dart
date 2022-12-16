import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/plant_details/plant_details_attributes.dart';
import 'package:fyto/widgets/plant_details/plant_details_description.dart';
import 'package:fyto/widgets/plant_details/plant_details_header.dart';
import 'package:path_provider/path_provider.dart';

enum Page {
  description,
  attributes,
}

class PlantDetails extends StatefulWidget {
  final Plant plant;

  const PlantDetails(this.plant);

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  String selectedImage = 'csorgo-kakascimer';
  Page selectedPage = Page.description;
  List<bool> isSelected = [true, false];

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
    return FutureBuilder(
      future: _getImage(),
      builder: (context, AsyncSnapshot<Image?> snapshot) => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              selectedPage = selectedPage == Page.description
                  ? Page.attributes
                  : Page.description;
            });
          },
          label: Text(
              selectedPage == Page.description ? 'Tulajdonságok' : 'Leírás',
              style: const TextStyle(fontWeight: FontWeight.w400)),
        ),
        body: Column(
          children: [
            PlantDetailsHeader(
              widget.plant.name,
              widget.plant.latinName,
              snapshot.data,
            ),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: selectedPage == Page.description
                  ? PlantDetailsDescription(widget.plant.description)
                  : PlantDetailsAttributes(widget.plant.attributes),
            )),
          ],
        ),
      ),
    );
  }
}
