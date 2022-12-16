import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<List<Image>> _getImages(latinName) async {
  final Directory applicationDirectory =
      await getApplicationDocumentsDirectory();
  final String plantDirectoryName =
      latinName.toLowerCase().replaceAll(' ', '_');
  final String plantDirectoryPath =
      '${applicationDirectory.path}/images/plants/$plantDirectoryName';
  final Directory plantDirectory = Directory(plantDirectoryPath);
  final List<Image> images = await plantDirectory.list().map((filePath) {
    return Image.file(filePath as File);
  }).toList();
  return images;
}

class ImageGrid extends StatelessWidget {
  final String latinName;

  const ImageGrid(this.latinName);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getImages(latinName),
      builder: (context, AsyncSnapshot<List<Image>> snapshot) => Scaffold(
        body: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          children: snapshot.data != null
              ? snapshot.data!
                  .map(
                    (image) => FittedBox(
                      fit: BoxFit.cover,
                      clipBehavior: Clip.hardEdge,
                      child: image,
                    ),
                  )
                  .toList()
              : [],
        ),
      ),
    );
  }
}
