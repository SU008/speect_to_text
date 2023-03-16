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
            Center(
              child: ElevatedButton(


                onPressed: () async {
                  final result = await FileSelector.selectFile();
                  if (result != null) {
                    setState(()  {
                      _filePath = result;
                      print(_filePath);
                    });
                    await _transcribeAudioFile(_filePath);
                  }
                },
                child: const Text('Select File'),
              ),
            ),
            const SizedBox(height: 5.0),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
