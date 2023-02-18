import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<Image> images;

  const ImageGrid(this.images, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: images.isNotEmpty
          ? images
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
    );
  }
}
