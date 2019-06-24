import 'package:flutter/material.dart';
import 'package:quiz_app_api/MyHomePage.dart';

void main () => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: new ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.indigoAccent),

      ),
      home: MyHomePage(),
      );
  }
}

