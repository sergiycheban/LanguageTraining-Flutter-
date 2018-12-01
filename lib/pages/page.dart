import 'package:flutter/material.dart';
import './word.dart';
import './translate.dart';
import './quiz.dart';

class MainPage extends StatefulWidget {
  @override
  Page createState() => new Page();
}

class Page extends State<MainPage> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();

    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TabBar getTabBar() {
    return new TabBar(
      tabs: <Tab>[
        new Tab(
          icon: new Icon(Icons.search),
        ),
        new Tab(
          icon: new Icon(Icons.question_answer),
        ),
        new Tab(
          icon: new Icon(Icons.translate),
        ),
      ],
      controller: controller,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return new TabBarView(
      children: tabs,
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Center(child: new Image.asset('assets/logo.png')),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green,
            bottom: getTabBar()),
        body: getTabBarView(
            <Widget>[new WordPage(), new QuizPage(), new TranslatePage()]));
  }
}
