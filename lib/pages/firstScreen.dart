import 'package:flutter/material.dart';
import './translate.dart';
import './quiz.dart';

const String _AccountName = 'Sergey Cheban';
const String _AccountEmail = 'sergiycheban1499@gmail.com';
const String _AccountAbbr = 'S-CH';


class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => new MyHomeState();
}

class MyHomeState extends State<MyHome> {
  static double _value = 4.0;

  int current_step = 0;
  bool isActive = false;
  List<Step> my_steps = [
    new Step(
        title: new Text("Basic"),
        content: new Text(""),
        isActive: true),
    new Step(
        title: new Text("Independent"),
        content: new Slider(
          min: 0.0,
          max: 100.0,
          value: _value,
          onChanged: (double value){ 
            
           },


        ),
        isActive: true),
    new Step(
        title: new Text("Proficient"),
        content: new Text(""),
        isActive: true),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text("Simple Material App"),
      ),
        drawer: Drawer(
          child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

            new UserAccountsDrawerHeader(
            accountName: const Text(_AccountName),
            accountEmail: const Text(_AccountEmail),
            currentAccountPicture: new CircleAvatar(
            backgroundColor: Colors.brown,
            child: new Text(_AccountAbbr)
            )
           ),

            ListTile(
              leading: const Icon(Icons.home),
              title: Text('Home'),
              onTap:()=>Navigator.push(context,MaterialPageRoute(builder: (context) => MyHome()))
            ),

             ListTile(
              leading: const Icon(Icons.keyboard),
              title: Text('Translate'),
              onTap:()=>Navigator.push(context,MaterialPageRoute(builder: (context) => TranslatePage()))
            ),

            ListTile(
              leading: const Icon(Icons.question_answer),
              title: Text('Quiz'),
              onTap:()=>Navigator.push(context,MaterialPageRoute(builder: (context) => Quiz1()))
            ),
          ],
        ),
      ),
      body: new Container(
        
        child: new Stepper(
        currentStep: this.current_step,
        steps: my_steps,
        type: StepperType.vertical,
        onStepTapped: (step) {
          
          setState(() {
            current_step = step;
          });
        },
         onStepCancel: () {
          setState(() {
            if (current_step > 0) {
              current_step = current_step - 1;
            } else {
              current_step = 0;
            }
          });
        },
        onStepContinue: () {
          setState(() {
            if (current_step < my_steps.length - 1) {
              current_step = current_step + 1;
            } else {
              current_step = 0;
            }
          });
        },
      )),
    );
  }
}