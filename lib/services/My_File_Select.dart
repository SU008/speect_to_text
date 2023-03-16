import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


/*
ensure in andriod manifest permission is allowed:
   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

 */

import 'dart:io';
import 'package:flutter_document_picker/flutter_document_picker.dart';

class FileSelector {
  static Future<String?> selectFile() async {



    final result = await FlutterDocumentPicker.openDocument();
    if (result != null) {
      if (await File(result).exists()) {
        return result;
      } else {
        return null;
       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("File does not exist."), ));
      }
    }
    return null;
  }
}
