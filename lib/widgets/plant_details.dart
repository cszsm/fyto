import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/utils/utils.dart';
import 'package:fyto/widgets/image_grid.dart';
import 'package:fyto/widgets/image_selector.dart';

enum Page {
  description,
  attributes,
}

class PlantDetails extends StatefulWidget {
  final Plant plant;

  PlantDetails(this.plant);

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  String selectedImage = 'csorgo-kakascimer';
  Page selectedPage = Page.description;
  List<bool> isSelected = [true, false];

  List<Widget> _listAttributes() {
    return widget.plant.attributes.entries.map((e) {
      String attributeType = resolveAttributeType(e.key);
      String attributeValue = resolveAttributeValue(e.value);
      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Text(
          '$attributeType: $attributeValue',
          style: const TextStyle(fontSize: 16),
        ),
      );
    }).toList();
  }

  void _updateImage(String selection) {
    setState(() {
      selectedImage = selection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: stack's probably not needed
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset('assets/images/$selectedImage.jpg'),
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageGrid(),
                          ))
                    },
                  ),
                  Positioned(
                      bottom: 8,
                      left: 24,
                      child: Column(
                        children: [
                          Text(
                            widget.plant.name,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.plant.latinName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: selectedPage == Page.description
                        ? SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                widget.plant.description,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                        : ListView(
                            // padding: EdgeInsets.symmetric(vertical: 6),
                            children: _listAttributes(),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: LayoutBuilder(
                  builder: (context, constraints) => ToggleButtons(
                    constraints:
                        BoxConstraints.expand(width: constraints.maxWidth / 2),
                    borderWidth: 0,
                    children: const [
                      Text('Leírás'),
                      Text('Tulajdonságok'),
                    ],
                    isSelected: isSelected,
                    onPressed: (int index) {
                      setState(() {
                        selectedPage =
                            index == 0 ? Page.description : Page.attributes;
                        isSelected[0] = selectedPage == Page.description;
                        isSelected[1] = selectedPage == Page.attributes;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          // Positioned(
          //   right: 10,
          //   top: 100,
          //   child: ImageSelector(selectedImage, _updateImage),
          // )
        ],
      ),
    );
  }
}
