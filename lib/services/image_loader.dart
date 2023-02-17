import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_archive/flutter_archive.dart';

class ImageLoader {
  Directory applicationDirectory;
  late File zipFile;
  late Directory plantsDirectory;

  ImageLoader(this.applicationDirectory) {
    final zipFilePath = '${applicationDirectory.path}/plants.zip';
    zipFile = File(zipFilePath);

    final plantsDirectoryPath = '${applicationDirectory.path}/images/plants';
    plantsDirectory = Directory(plantsDirectoryPath);
  }

  Future<void> _downloadZip() async {
    final ref = FirebaseStorage.instance
        .refFromURL('gs://fytowm.appspot.com/public/plants.zip');

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

  Future<void> download() async {
    await _downloadZip();
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
