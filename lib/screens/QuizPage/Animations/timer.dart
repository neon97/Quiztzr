import 'dart:async';

import 'package:edgeclass/constants/data.dart';
import 'package:edgeclass/constants/router.dart';
import 'package:edgeclass/screens/QuizPage/Animations/checkAndMove.dart';
import 'package:edgeclass/screens/QuizPage/quizHandler.dart';
import 'package:edgeclass/screens/ScorePage/scorePage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TimerTimeout extends StatefulWidget {
  final int questionIndex;
  final double timer;
  final int index;
  TimerTimeout(
      {@required this.timer,
      @required this.questionIndex,
      @required this.index});
  @override
  _TimerTimeoutState createState() => _TimerTimeoutState();
}

class _TimerTimeoutState extends State<TimerTimeout> {
  startTimer() {
    globalTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (clockTimer == 0) {
        globalTimer.cancel();
        //move to next screen
        listQuestions.length == widget.questionIndex + 1
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
                  questIndex: widget.questionIndex + 1,
                ));

        //state saving
        await checkAndMoveForScoreQuestionAttended(
            widget.questionIndex, widget.index, 0);
        await storeQuestionState(widget.index, widget.questionIndex, clockTimer,
            false, null, widget.timer.toInt());
      } else {
        setState(() {
          clockTimer--;
        });
      }
    });
  }

  @override
  void initState() {
    clockTimer = widget.timer;
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        child: SfRadialGauge(
          enableLoadingAnimation: true,
          axes: <RadialAxis>[
            RadialAxis(
                showLabels: false,
                showTicks: false,
                minimum: 0,
                maximum: widget.timer,
                startAngle: 270,
                endAngle: 270,
                axisLineStyle: const AxisLineStyle(
                    thicknessUnit: GaugeSizeUnit.factor, thickness: 0.03),
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      angle: 180,
                      widget: Text(
                        clockTimer.toInt().toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 35),
                      )),
                ],
                pointers: <GaugePointer>[
                  RangePointer(
                    value: clockTimer,
                    width: 12,
                    pointerOffset: -6,
                    cornerStyle: CornerStyle.bothCurve,
                    enableAnimation: true,
                    animationDuration: 1200,
                    animationType: AnimationType.ease,
                    sizeUnit: GaugeSizeUnit.logicalPixel,
                    // color: const Color(0xFFF67280),
                    gradient: const SweepGradient(
                        colors: <Color>[Color(0xFFFF7676), Color(0xFFF54EA2)],
                        stops: <double>[0.25, 0.75]),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
