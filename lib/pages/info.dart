import 'package:sergey/utils/utils.dart';
import 'package:sergey/utils/walkthrought.dart';
import './page.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final PageController controller = new PageController();
  int currentPage = 0;
  bool lastPage = false;

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      if (currentPage == 3) {
        lastPage = true;
      } else {
        lastPage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEEEEEE),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: PageView(
              children: <Widget>[
                Walkthrough(
                  title: Flutkart.wt1,
                  content: Flutkart.wc1,
                  imageIcon: Icons.mobile_screen_share,
                  imagecolor: Colors.green,
                ),
                Walkthrough(
                  title: Flutkart.wt2,
                  content: Flutkart.wc2,
                  imageIcon: Icons.translate,
                  imagecolor: Colors.green,
                ),
                Walkthrough(
                  title: Flutkart.wt3,
                  content: Flutkart.wc3,
                  imageIcon: Icons.question_answer,
                  imagecolor: Colors.green,
                ),
                Walkthrough(
                  title: Flutkart.wt4,
                  content: Flutkart.wc4,
                  imageIcon: Icons.verified_user,
                  imagecolor: Colors.green,
                ),
              ],
              controller: controller,
              onPageChanged: _onPageChanged,
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text(lastPage ? "" : Flutkart.skip,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  onPressed: () => lastPage
                      ? null
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new MainPage())),
                ),
                FlatButton(
                  child: Text(lastPage ? Flutkart.gotIt : Flutkart.next,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  onPressed: () => lastPage
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new MainPage()))
                      : controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
