import 'package:flutter/material.dart';

const images = [
  'bakszakall-virag',
  'salvia2',
  'tilia_tomentosa',
  'trifolium_fragiferum',
  'csorgo-kakascimer',
  'apro-lucerna',
  'bekabuzogany-termes',
  'virag',
  'trifolium_dubium',
  'bodzaleveleu_macskagyoker',
  'zergeboglar'
];

class ImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: images
            .map(
              (image) => FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: Image.asset('assets/images/$image.jpg'),
              ),
            )
            .toList(),
      ),
    );
  }
}
