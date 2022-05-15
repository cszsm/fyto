import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

Future<void> load() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final filePath = '${appDocDir.path}/plants.zip';

  appDocDir.list().forEach((element) {print(element);});

  // final dir = Directory(appDocDir.path);
  // final r = await dir.create(recursive: true);

  final file = File(filePath);
  final ref = FirebaseStorage.instance.refFromURL('gs://fytowm.appspot.com/public/plants.zip');

  final downloadTask = ref.writeToFile(file);
  // downloadTask.snapshotEvents.listen((event) {
  //   print(event);
  // });
}
