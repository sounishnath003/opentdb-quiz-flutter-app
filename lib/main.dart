import 'package:flutter/material.dart';
import 'package:quiz_app_api/MyHomePage.dart';

void main () => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: new ThemeData(
        fontFamily: "Product",
        primaryColor: Colors.white,
        primarySwatch: Colors.indigo,
        textTheme: TextTheme(
          title: new TextStyle(color: Colors.black,),
          body1: new TextStyle(color: Colors.black),
          body2: new TextStyle(color: Colors.black),
          subtitle: new TextStyle(color: Colors.black),
          subhead: new TextStyle(color: Colors.black)
          ),
        primaryTextTheme: TextTheme(
          title: new TextStyle(color: Colors.black)
        ),
        iconTheme: IconThemeData(color: Colors.indigoAccent),

      ),
      home: MyHomePage(),
      );
  }
}

