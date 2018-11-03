import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';


class TranslatePage extends StatefulWidget {
  @override
  Translate createState() => new Translate();
}

class Translate extends State<TranslatePage> {
  
  String text;
  List data;
  static String app_id = "&08c7cc13";
  static String app_key = "?d1777512acef30b94041baef971ffbe1";
  static String language = 'en';
  static String word_id = 'Ace';

  String url = 'https://od-api.oxforddictionaries.com:443/api/v1/entries/'  + language + '/'  + word_id.toLowerCase();

  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
 
 
    var extractdata = json.decode(response.body);
    data = extractdata["results"];
 
    print(data[0]["question"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Translate"),
      ),
       body: Center(
                   child:  new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      new Text("question",
                        style: new TextStyle(
                            fontSize: 22.0
                        ),),
                    ],
                  ),
      ),
      
    );
  }
}