
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';




class Quiz1 extends StatefulWidget {
  @override
  Quiz1State createState() => new Quiz1State();
}


class Quiz1State extends State<Quiz1> {

  String question = "";
  List arrAnswer = ["","","",""];
  String correctAnswer = "";
  List data;
  String url = 'https://opentdb.com/api.php?amount=1&difficulty=easy&type=multiple';

 
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
 
 
    var extractdata = json.decode(response.body);
    data = extractdata["results"];
    question = data[0]["question"];
    correctAnswer = data[0]["correct_answer"];
    arrAnswer = data[0]["incorrect_answers"];
    arrAnswer.add(correctAnswer);
    arrAnswer.sort();
  } 

  @override
  Widget build(BuildContext context) {
      double cWidth = MediaQuery.of(context).size.width;
    return Scaffold(
          appBar: new AppBar(
            title: new Text("Quiz"),
            ),
            

          body: new Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.topCenter,
            child: new Column(
              
              children: <Widget>[
                 new FloatingActionButton(
                      onPressed:() {
                        setState(() {
                         makeRequest();          
                        });
                      },
                      child: new Icon(Icons.skip_next),
                  ),

                new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      new Text(question,
                        style: new TextStyle(
                            fontSize: 22.0
                        ),),
                    ],
                  ),
                


                //image
                new Padding(padding: EdgeInsets.all(10.0)),
                new Padding(padding: EdgeInsets.all(10.0)),

                new Text(">><<",
                  style: new TextStyle(
                    fontSize: 20.0,
                  ),),


                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    //button 1
                    new MaterialButton(
                      minWidth:cWidth,
                      color: Colors.blueGrey,
                      onPressed: (){
                        //TODO
                      },
                      child: new Text(arrAnswer[0],
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                        ),),
                    ),

                    //button 2
                    new MaterialButton(
                      minWidth: cWidth,
                      color: Colors.blueGrey,
                      onPressed: (){
                        //TODO
                      },
                      child: new Text(arrAnswer[1],
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                        ),),
                    ),

                    //button 3
                    new MaterialButton(
                      minWidth: cWidth,
                      color: Colors.blueGrey,
                      onPressed: (){
                        //TODO
                      },
                      child: new Text(arrAnswer[2],
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                        ),),
                    ),

                    //button 4
                    new MaterialButton(
                      minWidth: cWidth,
                      color: Colors.blueGrey,
                      onPressed: (){
                        //TODO
                      },
                      child: new Text(arrAnswer[3],
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                        ),),
                    ),

                  ],
                ),
              ],
            ),
          ),
    );
  }
}