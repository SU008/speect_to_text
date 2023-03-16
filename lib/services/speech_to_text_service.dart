

//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

import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';//flutter pub add flutter_dotenv

import 'package:http/http.dart' as http;

class ChatGPTService {




  Future <String> transcribe(File audioFile) async {
    try {
      final endpoint = Uri.parse('https://api.openai.com/v1/audio/transcriptions');
      const tokenAPI = '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';
      const model = 'whisper-1';

      final request = http.MultipartRequest('POST', endpoint)
        ..headers['Authorization'] = 'Bearer $tokenAPI'
        ..headers['Content-Type'] = 'application/json'
        //..headers['Content-Type'] = 'multipart/form-data'
        ..fields['model'] = model
       // ..files.add( audioFile as http.MultipartFile);
      ..files.add(await http.MultipartFile.fromPath('file', audioFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseString);

        return jsonResponse['text'];
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      print(e);
      return 'could not convert';
    }
  }
}





Future<String> generateResponse(String prompt) async {
  const apiKey = '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';

  var url = Uri.https("api.openai.com", "/v1/audio/transcriptions");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $apiKey"
    },
    body: json.encode({
      "model": "text-davinci-003",
      "prompt": prompt,
      'temperature': 0,
      'max_tokens': 2000,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    }),
  );

  // Do something with the response
  Map<String, dynamic> newresponse = jsonDecode(response.body);

  return newresponse['choices'][0]['text'];
}
