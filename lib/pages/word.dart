import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart';

String result;
String key = "23OHQuJMvxmshA83ejUNEOfTameRp12brYqjsnBn8F6w7VgEVd";

String urlWord = "https://wordsapiv1.p.rapidapi.com/words/";

String word = "Example";
List<String> definitions = [
  "A representative form or pattern",
  "Something to be imitated",
  "An occurrence of something",
  "An item of information that is typical of a class or group",
  "Punishment intended as a warning to others",
  "A task performed or problem solved in order to develop skill or understanding"
];
List<String> example = [
  "I profited from his example",
  "No such found",
  "But there is always the famous example of the Smiths",
  "This patient provides a typical example of the syndrome",
  "They decided to make an example of him",
  "You must work the examples at the end of each chapter in the textbook"
];
List<String> synonyms = ["model"];

fetchWord(String url) async {
  print("sterrrrrrrt");
  final JsonDecoder _decoder = new JsonDecoder();
  var clientHttp = new Client();
  var response = await clientHttp.get(url, headers: {
    "X-RapidAPI-Key": "23OHQuJMvxmshA83ejUNEOfTameRp12brYqjsnBn8F6w7VgEVd"
  });

  final String jsonBody = response.body;
  final statusCode = response.statusCode;

  if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
    throw Exception('Failed to load post');
  }

  final recipesContainer = _decoder.convert(jsonBody);
  final map = recipesContainer['results'];
  final mapSynonyms = recipesContainer['results'][0]["synonyms"];

  definitions.clear();
  example.clear();
  synonyms.clear();

  for (int i = 0; i < mapSynonyms.length; ++i) {
    synonyms.add(mapSynonyms[i]);
  }

  for (int i = 0; i < map.length; ++i) {
    definitions.add(map[i]['definition']);

    if (!map[i]['examples'].toString().isEmpty &&
        map[i]['examples'].toString() != "null") {
      example.add(map[i]['examples'][0]);
    } else {
      example.add("No such found");
    }
  }

  word = recipesContainer["word"];
  word = word[0].toUpperCase() + word.substring(1);

  print("ennnnnd");
}

class WordPage extends StatefulWidget {
  @override
  Word createState() => new Word();
}

class Word extends State<WordPage> {
  List data;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: new ListView(
          children: <Widget>[
            new Container(
              child: new Row(
                children: <Widget>[
                  new Flexible(
                    child: new TextField(
                      controller: myController,
                      onEditingComplete: () {
                        setState(() async {
                          await fetchWord(urlWord + myController.text);
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.green)),
                          labelText: 'Search',
                          hintText: 'What word would you like to know',
                          suffixStyle: const TextStyle(color: Colors.green)),
                    ),
                  ),
                  new Container(
                    child: new IconButton(
                      color: Colors.green,
                      icon: new Icon(Icons.send),
                      onPressed: () {
                        setState(() async {
                          await fetchWord(urlWord + myController.text);
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            new Padding(padding: EdgeInsets.all(18.0)),
            new Column(
              children: <Widget>[
                new Text(
                  word,
                  style: new TextStyle(fontSize: 60.0),
                ),
              ],
            ),
            new Padding(padding: EdgeInsets.all(9.0)),
            new Row(
              children: <Widget>[
                new Text("Definitions:",
                    style: TextStyle(fontSize: 28.0),
                    textAlign: TextAlign.start),
              ],
            ),
            new Padding(padding: EdgeInsets.all(5.0)),
            new Column(
              children: new List.generate(definitions.length, (int index) {
                return new ExpansionTile(
                  leading: const Icon(Icons.arrow_right),
                  title: new Text("${definitions[index]}"),
                  children: <Widget>[
                    new Text(
                      "Example:",
                      style: TextStyle(fontSize: 22.0),
                      textAlign: TextAlign.left,
                    ),
                    new Text(
                      "${example[index]}",
                      style: TextStyle(fontSize: 19.0),
                      textAlign: TextAlign.start,
                    ),
                  ],
                );
              }),
            ),
            new Padding(padding: EdgeInsets.all(15.0)),
            new Text(
              "Synonyms:",
              style: TextStyle(fontSize: 28.0),
              textAlign: TextAlign.start,
            ),
            new Column(
              children: new List.generate(synonyms.length, (int index) {
                return new ListTile(
                  leading: const Icon(Icons.arrow_right),
                  title: new Text("${synonyms[index]}"),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
