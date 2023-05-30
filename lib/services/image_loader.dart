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

  Stream<double> _downloadZip(bool test) async* {
    final refUrl =
        test ? '$baseUrl/$pathTest/$filename' : '$baseUrl/$pathProd/$filename';
    final ref = FirebaseStorage.instance.refFromURL(refUrl);
    final downloadTask = ref.writeToFile(zipFile);

    await for (final event in downloadTask.snapshotEvents) {
      switch (event.state) {
        case TaskState.running:
          yield event.bytesTransferred / event.totalBytes;
          break;
        case TaskState.paused:
          break;
        case TaskState.success:
        case TaskState.canceled:
        case TaskState.error:
          return;
      }
    }
  }

  Stream<double> _unzip() {
    late StreamController<double> controller;

    void startUnzip() {
      try {
        ZipFile.extractToDirectory(
          zipFile: zipFile,
          destinationDir: plantsDirectory,
          onExtracting: (zipEntry, progress) {
            controller.add(progress / 100);
            return ZipFileOperation.includeItem;
          },
        ).then((value) => controller.close());
      } catch (e) {
        // TODO: handle error properly
        print(e);
      }
    }

    controller = StreamController<double>(
      onListen: startUnzip,
    );
    return controller.stream;
  }

  Stream<double> download(bool test) async* {
    await for (final downloadProgress in _downloadZip(test)) {
      yield downloadProgress / 2;
    }

    await for (final unzipProgress in _unzip()) {
      yield unzipProgress / 2 + 0.5;
    }

    await zipFile.delete();

    // await applicationDirectory.list().forEach((element) {
    //   print(element);
    // });
  }

  isDownloadNeeded() async {
    final exists = await plantsDirectory.exists();
    return !exists;
  }
}
