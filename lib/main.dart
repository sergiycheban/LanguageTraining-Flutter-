import 'package:flutter/material.dart';
import './pages/firstScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      //   theme: ThemeData(
      //   brightness: Brightness.dark,
      //   primaryColor: Colors.lightBlue[800],
      //   accentColor: Colors.cyan[600],
      // ),
      home: new MyHome(),

    );
  }
}
