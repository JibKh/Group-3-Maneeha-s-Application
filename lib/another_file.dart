// THIS FILE IS COMPLETELY USELESS.
// ITS PURPOSE IS TO STOP THE TEST ERRORS IN DEBUGGING.

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: 'FlutterApp',
     debugShowCheckedModeBanner: true,
     theme: ThemeData(
        primaryColor: Colors.black12,
        accentColor: Colors.orange,
     ),
     home: Scaffold(
       appBar: AppBar(
         title: Text('Stateless'),
         backgroundColor: Colors.black,
         ),
   ),);
  }
}