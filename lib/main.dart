import 'package:flutter/material.dart';

import 'home.dart';


void main() {


  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,//to turn off debug banner
    initialRoute: '/',//temporarly make this the first page
    routes: {

      '/': (context) => const Home(),


    },
  )
  );
}

