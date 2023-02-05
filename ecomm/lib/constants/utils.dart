import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger
    .of(context)
    .showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
          kIsWeb
            ? images.add(File('https://www.shutterstock.com/shutterstock/photos/358894625/display_1500/stock-vector-broken-link-cannot-display-internet-page-icon-vector-illustration-358894625.jpg')) // imagem genérica para web
            : images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return images;
}
