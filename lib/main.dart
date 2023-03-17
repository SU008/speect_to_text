import 'package:flutter/material.dart';

import 'home.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main()  async {

  await dotenv.load(fileName: ".env");

  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,//to turn off debug banner
    initialRoute: '/',//temporarly make this the first page
    routes: {

      '/': (context) => const Home(),


    },
  )
  );
}

