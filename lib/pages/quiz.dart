import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sergey/utils/correctWrong.dart';
import 'package:html_unescape/html_unescape.dart';

import 'dart:convert';

String question = "Who of the anime naruto the strongest?";
List arrAnswer = ["Saske", "Naruto", "Itachi", "Madara"];
String correctAnswer = "Sacura";
List data;
String url =
    'https://opentdb.com/api.php?amount=1&difficulty=easy&type=multiple';

fetch(String url) async {
  var unescape = new HtmlUnescape();

  final JsonDecoder _decoder = new JsonDecoder();
  var clientHttp = new Client();
  var response = await clientHttp.get(url);

  final String jsonBody = response.body;
  final statusCode = response.statusCode;

  if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
    throw Exception('Failed to load post');
  }

  final recipesContainer = _decoder.convert(jsonBody);

  final List data = recipesContainer['results'];

  print(recipesContainer);
  print(data);

  question = unescape.convert(data[0]["question"]);
  correctAnswer = data[0]["correct_answer"];
  arrAnswer = data[0]["incorrect_answers"];
  arrAnswer.add(correctAnswer);
  arrAnswer.sort();
}

class QuizPage extends StatefulWidget {
  @override
  QuizState createState() => new QuizState();
}

class QuizState extends State<QuizPage> {
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  void handleAnswer(bool answer) {
    isCorrect = answer;
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new ListView(
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(8.0)),
            new Text(
              question,
              style: new TextStyle(fontSize: 22.0),
            ),
            new Image.asset('assets/cat.png'),
            new Padding(padding: EdgeInsets.all(10.0)),
            new Column(
              children: <Widget>[
                new MaterialButton(
                  minWidth: cWidth,
                  color: Colors.green,
                  onPressed: () {
                    setState(() async {
                      if (correctAnswer == arrAnswer[0]) {
                        await fetch(url);
                        handleAnswer(true);
                      } else {
                        await fetch(url);
                        handleAnswer(false);
                      }
                    });
                  },
                  child: new Text(
                    arrAnswer[0],
                    style: new TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
                new MaterialButton(
                  minWidth: cWidth,
                  color: Colors.green,
                  onPressed: () {
                    setState(() async {
                      if (correctAnswer == arrAnswer[1]) {
                        await fetch(url);
                        handleAnswer(true);
                      } else {
                        await fetch(url);
                        handleAnswer(false);
                      }
                    });
                  },
                  child: new Text(
                    arrAnswer[1],
                    style: new TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
                new MaterialButton(
                  minWidth: cWidth,
                  color: Colors.green,
                  onPressed: () {
                    setState(() async {
                      if (correctAnswer == arrAnswer[2]) {
                        await fetch(url);
                        handleAnswer(true);
                      } else {
                        await fetch(url);
                        handleAnswer(false);
                      }
                    });
                  },
                  child: new Text(
                    arrAnswer[2],
                    style: new TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
                new MaterialButton(
                  minWidth: cWidth,
                  color: Colors.green,
                  onPressed: () {
                    setState(() async {
                      if (correctAnswer == arrAnswer[3]) {
                        await fetch(url);
                        handleAnswer(true);
                      } else {
                        await fetch(url);
                        handleAnswer(false);
                      }
                    });
                  },
                  child: new Text(
                    arrAnswer[3],
                    style: new TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
        overlayShouldBeVisible == true
            ? new CorrectWrongOverlay(isCorrect, () {
                this.setState(() {
                  overlayShouldBeVisible = false;
                });
              })
            : new Container(),
      ],
    );
  }
}
