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
  try {
    final List<Image> images = await plantDirectory.list().map((filePath) {
      return Image.file(filePath as File);
    }).toList();
    return images;
  } catch (e) {
    return [Image.asset('assets/images/missing.png')];
  }
}

class ImageGrid extends StatelessWidget {
  final String latinName;

  const ImageGrid(this.latinName, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getImages(latinName),
      builder: (context, AsyncSnapshot<List<Image>> snapshot) => GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: snapshot.data != null
            ? snapshot.data!
                .map(
                  (image) => ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      clipBehavior: Clip.hardEdge,
                      child: image,
                    ),
                  ),
                )
                .toList()
            : [],
      ),
    );
  }
}
