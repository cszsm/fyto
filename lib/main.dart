import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/attribute_selector.dart';

import 'data/plant_attributes.dart';
import 'utils/plant_filter.utils.dart';

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
  String text = '';

  void _filterPlants(Map<int, int> selection) {
    final criteria = PlantAttributes(
        flower: selection[11],
        leafShape: selection[12],
        leafEdge: selection[13],
        leafClamp: selection[14],
        flowerShape: selection[21],
        flowerColour: selection[22],
        stemShape: selection[23],
        crustPattern: selection[31],
        crustColour: selection[32],
        crop: selection[33]);
    final r = filterPlants(criteria, plants);
    setState(() {
      if (r.length > 1) {
        text = 'found ${r.length} plants';
      } else if (r.length == 1) {
        text = r[0].name;
      } else {
        text = 'there\'s no such plant';
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
            Container(
              child: AttributeSelector(_filterPlants),
              height: availableHeigth * 0.9,
            ),
            Container(
              child: Text(text),
              height: availableHeigth * 0.1,
            )
          ],
        ));
  }
}
