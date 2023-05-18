import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_archive/flutter_archive.dart';

const baseUrl = 'gs://fytowm.appspot.com/public';
const pathProd = 'prod';
const pathTest = 'test';
const filename = 'plants.zip';

class ImageLoader {
  Directory applicationDirectory;
  late File zipFile;

  late Directory plantsDirectory;
  late Directory testPlantsDirectory;

  ImageLoader(this.applicationDirectory) {
    final zipFilePath = '${applicationDirectory.path}/$filename';
    zipFile = File(zipFilePath);

    final plantsDirectoryPath = '${applicationDirectory.path}/images';
    plantsDirectory = Directory(plantsDirectoryPath);
  }

  Future<void> _downloadZip(bool test) async {
    final refUrl =
        test ? '$baseUrl/$pathTest/$filename' : '$baseUrl/$pathProd/$filename';
    final ref = FirebaseStorage.instance.refFromURL(refUrl);

    final completer = Completer();

    final downloadTask = ref.writeToFile(zipFile);
    downloadTask.snapshotEvents.listen((event) {
      switch (event.state) {
        case TaskState.running:
        case TaskState.paused:
          print('totalBytes');
          print(event.totalBytes);
          print('bytesTransferred');
          print(event.bytesTransferred);
          break;
        case TaskState.success:
        case TaskState.canceled:
        case TaskState.error:
          completer.complete();
          break;
      }
    });

    return completer.future;
  }

  Future<void> _unzip() async {
    try {
      await ZipFile.extractToDirectory(
          zipFile: zipFile, destinationDir: plantsDirectory);
    } catch (e) {
      print(e);
    }
  }

  Future<void> download(bool test) async {
    await _downloadZip(test);
    await _unzip();
    await zipFile.delete();

    await applicationDirectory.list().forEach((element) {
      print(element);
    });
  }

  isDownloadNeeded() async {
    final exists = await plantsDirectory.exists();
    return !exists;
  }
}
