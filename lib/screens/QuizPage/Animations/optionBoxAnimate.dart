import 'dart:async';
import 'package:edgeclass/constants/data.dart';
import 'package:edgeclass/constants/router.dart';
import 'package:edgeclass/screens/QuizPage/Animations/checkAndMove.dart';
import 'package:edgeclass/screens/QuizPage/quizHandler.dart';
import 'package:edgeclass/screens/ScorePage/scorePage.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_icons/flutter_icons.dart';

class OptionAnimate extends StatefulWidget {
  final Widget child;
  final int delay;
  final int isCorrect;
  final int score;
  final int quesIndex;
  final int index;
  final String selectedString;
  final int limitTimer;

  OptionAnimate(
      {@required this.child,
      @required this.limitTimer,
      @required this.selectedString,
      @required this.index,
      this.delay,
      @required this.isCorrect,
      @required this.score,
      @required this.quesIndex});

  @override
  _OptionAnimateState createState() => _OptionAnimateState();
}

class _OptionAnimateState extends State<OptionAnimate>
    with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<double> _rotateAnimate;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);

    _rotateAnimate = Tween<double>(begin: 0.10, end: 0.0).animate(curve);
    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => CorrectIonPage(
                      limitTimer: widget.limitTimer,
                      selectedString: widget.selectedString,
                      score: widget.score,
                      index: widget.index,
                      quesIndex: widget.quesIndex,
                      isCorrect: widget.isCorrect,
                      child: widget.child,
                      tag: widget.delay.toString(),
                      delay: 3,
                    )));
      },
      child: FadeTransition(
        child: RotationTransition(
          turns: _rotateAnimate,
          child: Hero(
            tag: widget.delay.toString(),
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(31, 36, 46, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: widget.child,
            ),
          ),
        ),
        opacity: _animController,
      ),
    );
  }
}

class CorrectIonPage extends StatefulWidget {
  final int score;
  final int index;
  final int isCorrect;
  final Widget child;
  final String tag;
  final int delay;
  final int quesIndex;
  final String selectedString;
  final int limitTimer;
  CorrectIonPage(
      {@required this.selectedString,
      @required this.limitTimer,
      @required this.score,
      @required this.index,
      this.child,
      this.tag,
      this.delay,
      @required this.isCorrect,
      @required this.quesIndex});
  @override
  _CorrectIonPageState createState() => _CorrectIonPageState();
}

class _CorrectIonPageState extends State<CorrectIonPage>
    with TickerProviderStateMixin {
  AnimationController _animController;
  Animation _animFlip;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _animFlip = Tween<double>(end: math.pi, begin: math.pi * 2)
        .animate(_animController);
    _animController.addListener(() {
      setState(() {});
    });
    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
        Timer(Duration(seconds: 5), routeToNextQuestion);
      });
    }
    super.initState();
  }

  routeToNextQuestion() async {
    globalTimer.cancel();
    await checkAndMoveForScoreQuestionAttended(
        widget.quesIndex, widget.index, widget.score);
    await storeQuestionState(
        widget.index,
        widget.quesIndex,
        clockTimer,
        widget.score == 0 ? false : true,
        widget.selectedString,
        widget.limitTimer);
    listQuestions.length == widget.quesIndex + 1
        ? routeTo(
            context,
            ScorePage(
              index: widget.index,
            ))
        : routeTo(
            context,
            QuizHandler(
              index: widget.index,
              fromSharedPrefs: false,
              questIndex: widget.quesIndex + 1,
            ));
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
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
          child: Center(
            child: Hero(
              tag: widget.tag.toString(),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateY(_animFlip.value),
                child: _animFlip.value < 4.71
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(widget.isCorrect == 1
                              ? "assets/correct.gif"
                              : "assets/wrong.gif"),
                          Container(
                              height: deviceWidth / 2.5,
                              width: deviceWidth / 2.5,
                              padding: EdgeInsets.all(8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(31, 36, 46, 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: widget.isCorrect == 1
                                  ? Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          left: 115,
                                          child: Transform(
                                            transform:
                                                Matrix4.rotationY(math.pi),
                                            child: Icon(
                                              MaterialIcons.check,
                                              color: Colors.green,
                                              size: 100,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 100,
                                    )),
                        ],
                      )
                    : Container(
                        height: deviceWidth / 2.5,
                        width: deviceWidth / 2.5,
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(31, 36, 46, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: widget.child,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
