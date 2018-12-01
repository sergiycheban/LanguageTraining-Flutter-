import 'package:flutter/material.dart';
import './pages/splash.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Duosergey',
      //   theme: ThemeData(
      //   brightness: Brightness.dark,
      //   primaryColor: Colors.lightBlue[800],
      //   accentColor: Colors.cyan[600],
      // ),
      home: new SplashScreen(),
    );
  }
}
