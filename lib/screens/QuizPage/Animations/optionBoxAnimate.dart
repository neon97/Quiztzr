import 'dart:async';

import 'package:edgeclass/constants/data.dart';
import 'package:edgeclass/constants/router.dart';
import 'package:edgeclass/screens/QuizPage/quizHome.dart';
import 'package:flutter/material.dart';

class OptionAnimate extends StatefulWidget {
  final Widget child;
  final int delay;

  OptionAnimate({@required this.child, this.delay});

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
        globalChild = widget.child;
        globalValue = widget.delay;
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 2),
                pageBuilder: (_, __, ___) => Page2()));
      },
      child: FadeTransition(
        child: RotationTransition(
          turns: _rotateAnimate,
          child: Hero(
            tag: widget.delay.toString(),
            child: Container(
              // transform: translateValue,
              // duration: Duration(seconds: 5),
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

int globalValue;
Widget globalChild;

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              child: Text('Page2'),
              onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(seconds: 2),
                      pageBuilder: (_, __, ___) => Page2())),
            ),
            Hero(tag: 'home', child: Icon(Icons.home))
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        color: Colors.transparent,
        height: deviceHeight,
        width: deviceWidth,
        child: Center(
          child: Hero(
            tag: globalValue.toString(),
            child: Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(31, 36, 46, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: globalChild,
            ),
          ),
        ),
      ),
    );
  }
}
