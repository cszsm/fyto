import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/attribute_selector.dart';
import 'package:fyto/widgets/plant_details.dart';
import 'package:fyto/widgets/result_selector_dialog.dart';

import 'data/plants.dart';
import 'utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fyto',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'fyto'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Plant> foundPlants = [];
  String text = 'select an attribute';
  bool isPlantFound = false;

  void _filterPlants(Map<String, String> selection) {
    final criteria = PlantAttributes(selection);
    final p = plants.map((e) => Plant.fromRaw(e)).toList();
    foundPlants = filterPlants(criteria, p);
    setState(() {
      if (foundPlants.length > 1) {
        text = 'found ${foundPlants.length} plants';
        isPlantFound = false;
      } else if (foundPlants.length == 1) {
        text = foundPlants[0].name;
        isPlantFound = true;
      } else {
        text = 'there\'s no such plant';
        isPlantFound = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Text(widget.title),
    );

    final availableHeigth = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;

    return Scaffold(
        appBar: appBar,
        body: Column(
          children: [
            SizedBox(
              child: AttributeSelector(_filterPlants),
              height: availableHeigth * 0.9,
            ),
            Container(
              child: OutlinedButton(
                onPressed: isPlantFound
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlantDetails(foundPlants[0])));
                      }
                    : () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ResultSelectorDialog(foundPlants);
                            });
                      },
                child: Text(text),
              ),
              height: availableHeigth * 0.1,
              padding: const EdgeInsets.all(10),
            )
          ],
        ));
  }
}
