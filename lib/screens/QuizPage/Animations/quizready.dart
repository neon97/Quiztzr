import 'dart:async';

import 'package:animated_text/animated_text.dart';
import 'package:edgeclass/constants/data.dart';
import 'package:edgeclass/constants/router.dart';
import 'package:edgeclass/screens/QuizPage/Animations/showUp.dart';
import 'package:edgeclass/screens/QuizPage/questionHome.dart';
import 'package:flutter/material.dart';

class QuizReady extends StatefulWidget {
  final int quesIndex;
  final int index;
  QuizReady({@required this.quesIndex, @required this.index});
  @override
  _QuizReadyState createState() => _QuizReadyState();
}

class _QuizReadyState extends State<QuizReady> {
  AnimatedTextController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimatedTextController.play;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          height: deviceHeight,
          width: deviceWidth,
          child: ShowUp(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Get Ready",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: deviceWidth,
                  height: 200,
                  child: AnimatedText(
                    alignment: Alignment.center,
                    speed: Duration(milliseconds: 1000),
                    controller: _controller,
                    displayTime: Duration(milliseconds: 1000),
                    wordList: ['3', '2', '1'],
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 120,
                        fontWeight: FontWeight.w700),
                    onAnimate: (index) {
                      print(index);
                      if (index == 2) {
                        Timer(Duration(milliseconds: 1000), routeForQuiz);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  routeForQuiz() {
    setState(() {
      _controller = AnimatedTextController.stop;
    });
    routeTo(
        context,
        QuizStart(
          index: widget.index,
          quesIndex: widget.quesIndex,
        ));
  }
}
