import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:quiz_app_api/Quiz.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Quiz quiz ;
  List<Results> results ;


  Future<void> fetchData() async {
    final url = await http.get("https://opentdb.com/api.php?amount=30");
    if (url.statusCode == 200) {
      var decodeRes = jsonDecode(url.body) ;
      print(decodeRes);
      quiz = Quiz.fromJson(decodeRes);
      results = quiz.results ;
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
      body: _appBody(),
    );
  }
}

Widget _appBody() {

  Quiz quiz ;
  List<Results> results ;

  Future<void> fetchData() async {
    final url = await http.get("https://opentdb.com/api.php?amount=30");
    if (url.statusCode == 200) {
      var decodeRes = jsonDecode(url.body) ;
      print(decodeRes);
      quiz = Quiz.fromJson(decodeRes);
      results = quiz.results ;
      //print(results);
    } else {
      throw Exception("Failed to load, try again later");
    }
  }

  return new FutureBuilder(
    future: fetchData(),
    initialData: 56,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
            return new Text("Press button to start");
          break;
          case ConnectionState.active:
          case ConnectionState.waiting:
            return new Center(
              child: new CircularProgressIndicator()
              );

          case ConnectionState.done:
          if(snapshot.hasError) {
            return Container(

            );
          } else {
            return Container(
              child: new Text("Data Arrived"),
            );
          }
        default:
      }
    },
  );
}
