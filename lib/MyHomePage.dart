import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app_api/Quiz.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Quiz quiz;
  List<Results> results;

  Future<void> fetchData() async {
    final url = await http.get("https://opentdb.com/api.php?amount=40");
    if (url.statusCode == 200) {
      var decodeRes = jsonDecode(url.body);
      print(decodeRes);
      quiz = Quiz.fromJson(decodeRes);
      results = quiz.results;
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
  Quiz quiz;
  List<Results> results;

  Future<void> _fetchData() async {
    final url = await http.get("https://opentdb.com/api.php?amount=30");
    if (url.statusCode == 200) {
      var decodeRes = jsonDecode(url.body);
      print(decodeRes);
      quiz = Quiz.fromJson(decodeRes);
      results = quiz.results;
      //print(results);
    } else {
      throw Exception("Failed to load, try again later");
    }
  }

  return new FutureBuilder(
    future: _fetchData(),
    initialData: 56,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return new Text("Press button to start");
          break;
        case ConnectionState.active:
          return Center(
            child: new Text("In Progress..."),
          );
          break;
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());
          break;
        case ConnectionState.done:
          if (snapshot.hasError) {
            return Container();
          } else {
            return ListView.builder(
                itemCount: results.length,
                itemBuilder: (BuildContext context, int index) => new Card(
                      child: new Text("2"),
                    )
              );
          }
          break;
        default:
      }
    },
  );
}
