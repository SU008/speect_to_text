import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:speech_to_text/services/My_File_Select.dart';
import 'package:speech_to_text/services/speech_to_text_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _filePath = "";
  String _transcriptionResult = '';
  final _chatGPTService = ChatGPTService();
  String fileUploadStatus = "";

  Future<void> _transcribeAudioFile(String audioFilePath) async {
    setState(() {
      _transcriptionResult = 'Transcribing...';
    });

    final audioFile = File(audioFilePath);
    String transcription = await _chatGPTService.transcribe(audioFile);

    setState(() {
      _transcriptionResult = transcription;
    });
  }

  bool isFileOver25MB(File file) {
    final int fileSizeInBytes = file.lengthSync();
    final int fileSizeInMB = fileSizeInBytes ~/ (1024 * 1024); // Convert bytes to MB
    return fileSizeInMB > 25;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Uploader"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(height: 50),
            const Text(
                textScaleFactor: 1.2 ,
                textAlign: TextAlign.center,
                "File uploads are currently limited to 25 MB and the following input file types are supported: mp3, mp4, mpeg, mpga, m4a, wav, and webm"),
            const SizedBox(height: 50),
            Text( fileUploadStatus),

            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(


                onPressed: () async {
                  final result = await FileSelector.selectFile();
                  if (result != null) {
                    setState(()  {
                      _filePath = result;
                      print(_filePath);
                    });


                    //----checking file size------------------
                    if ( isFileOver25MB( File(_filePath) )   ){
                      setState(() {
                        fileUploadStatus = "File larger than 25MB, unable to upload";
                      });
                    }else{
                      setState(() {
                        fileUploadStatus = "Upload Successful";
                      });
                    }
                    //-----------------------------------------

                    //transcribe in progress
                    await _transcribeAudioFile(_filePath);

                  }
                },
                child: const Text('Select File'),
              ),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _transcriptionResult,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
