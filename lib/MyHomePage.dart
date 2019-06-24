import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Future<void> fetchData() async {
    final url = await http.get("https://opentdb.com/api.php?amount=30");
    if (url.statusCode == 200) {
      var decodeRes = jsonDecode(url.body) ;
      
    } else {
      throw Exception("Failed to load, try again later");
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Quiz App"),
        centerTitle: true,
        titleSpacing: 2.0,
        backgroundColor: Colors.white,
        elevation: 1.0,
      ),
      body: null,
    );
  }
}
