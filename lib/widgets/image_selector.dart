import 'package:flutter/material.dart';

const images = [
  'bakszakall-virag',
  'salvia2',
  'tilia_tomentosa',
  'trifolium_fragiferum'
];

// TODO: remove if unused
class ImageSelector extends StatefulWidget {
  final String preSelection;
  final Function onSelectionChanged;

  const ImageSelector(this.preSelection, this.onSelectionChanged);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  String selection = '';

  @override
  void initState() {
    super.initState();
    selection = widget.preSelection;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: images
            .map((image) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: GestureDetector(
                    child: SizedBox(
                      height: selection == image ? 80 : 60,
                      width: selection == image ? 80 : 60,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          'assets/images/$image.jpg',
                          // fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selection = image;
                      });
                      widget.onSelectionChanged(image);
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }
}
