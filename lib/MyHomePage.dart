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
            return SafeArea(
              child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (BuildContext context, int index) => new Card(
                      color: Colors.white,
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ExpansionTile(
                            title: new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  results[index].question,
                                  style: new TextStyle(
                                    fontSize: 17.0,
                                    //fontWeight: FontWeight.bold
                                  ),
                                ),
                                new FittedBox(
                                    child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    FilterChip(
                                      label: new Text(results[index].category),
                                      backgroundColor: Colors.indigo[50],
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      onSelected: (bool value) {},
                                    ),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    FilterChip(
                                      label:
                                          new Text(results[index].difficulty),
                                      backgroundColor: Colors.indigo[50],
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      onSelected: (bool value) {},
                                    )
                                  ],
                                )),
                              ],
                            ),
                            leading: new CircleAvatar(
                              child: new Text(
                                  (results[index].type.startsWith("m")
                                      ? "M"
                                      : "B")),
                              backgroundColor: Colors.greenAccent,
                              foregroundColor: Colors.black,
                            ),
                            children: results[index].allAnswers.map((m) {
                              return AnswerWidget(
                                  results: results, index: index, m: m);
                            }).toList()),
                      ))),
            );
          }
          break;
        default:
      }
    },
  );
}

class AnswerWidget extends StatefulWidget {
  final List<Results> results;
  final int index;
  final String m;

  AnswerWidget({this.results, this.index, this.m});

  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new ListTile(
      onTap: () {},
      title: new Text(
        widget.m,
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontSize: 18,
        ),
      ),
    ));
  }
}
