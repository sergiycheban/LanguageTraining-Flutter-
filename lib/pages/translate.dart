import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart';

String result = "";

String urlTranslate =
    "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20181017T144415Z.2e31cc084f129683.c73821dab02a400d5b7cbc373e47622ef2e2425a&lang=ru-en&text=";

fetchTranslate(String url) async {
  print("sterrrrrrrt");
  final JsonDecoder _decoder = new JsonDecoder();
  var clientHttp = new Client();
  var response = await clientHttp.get(url);

  final String jsonBody = response.body;
  final statusCode = response.statusCode;

  if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
    throw Exception('Failed to load post');
  }

  final recipesContainer = _decoder.convert(jsonBody);

  print(recipesContainer["text"][0]);

  result = recipesContainer["text"][0];

  print("ennnnnd");
}

class TranslatePage extends StatefulWidget {
  @override
  Translate createState() => new Translate();
}

class Translate extends State<TranslatePage> {
  List data;
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: new ListView(
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.all(2.0),
                  child: new Row(
                    children: <Widget>[
                      new Flexible(
                        child: new TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          controller: myController,
                          onEditingComplete: () {
                            setState(() async {
                              await fetchTranslate(
                                  urlTranslate + myController.text);
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });
                          },
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.green)),
                              labelText: 'Translator',
                              hintText: 'What would you like to translate',
                              suffixStyle:
                                  const TextStyle(color: Colors.green)),
                        ),
                      ),
                      new Container(
                        margin: new EdgeInsets.symmetric(horizontal: 4.0),
                        child: new IconButton(
                          color: Colors.green,
                          icon: new Icon(Icons.send),
                          onPressed: () {
                            setState(() async {
                              await fetchTranslate(
                                  urlTranslate + myController.text);
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(padding: EdgeInsets.all(18.0)),
                new Text(
                  result,
                  style: new TextStyle(fontSize: 28.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
