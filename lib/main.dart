import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/services/image_loader.dart';
import 'package:fyto/widgets/attribute_category_selector.dart';
import 'package:fyto/widgets/plant_details.dart';
import 'package:fyto/widgets/result_selector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';

import 'data/plants.dart';
import 'utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fyto',
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
  String text = 'Válasszon jellemzőt';
  bool isPlantFound = false;
  bool fabEnabled = false;

  void _filterPlants(Map<String, String> selection) {
    final criteria = PlantAttributes(selection);
    final p = plants.map((e) => Plant.fromRaw(e)).toList();
    foundPlants = filterPlants(criteria, p);
    setState(() {
      if (selection.isEmpty) {
        text = 'Válasszon jellemzőt';
        isPlantFound = false;
        fabEnabled = false;
      } else if (foundPlants.length > 1) {
        text = '${foundPlants.length} talált növény';
        isPlantFound = false;
        fabEnabled = true;
      } else if (foundPlants.length == 1) {
        text = foundPlants[0].name;
        isPlantFound = true;
        fabEnabled = true;
      } else {
        text = 'Nincs ilyen növény';
        isPlantFound = false;
        fabEnabled = false;
      }
    });
  }

  Future<void> _downloadImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final loader = ImageLoader(directory);
    final needed = await loader.isDownloadNeeded();
    if (needed) {
      print('download needed');
      loader.download();
    } else {
      print('download not needed');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));
    _downloadImages();

    final availableHeigth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: AttributeSelector(_filterPlants),
        ),
        height: availableHeigth,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: fabEnabled
            ? (isPlantFound
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
                          return ResultSelector(foundPlants);
                        });
                  })
            : null,
        label: Text(
          text,
          style: TextStyle(
            color: fabEnabled ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: fabEnabled ? Colors.green : Colors.grey[100],
      ),
    );
  }
}
