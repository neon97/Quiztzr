import 'package:edgeclass/Database/topics.dart';
import 'package:edgeclass/Database/userlog.dart';
import 'package:edgeclass/constants/sharedPrefs.dart';
import 'package:edgeclass/screens/QuizPage/Animations/quizready.dart';
import 'package:flutter/material.dart';

class QuizHandler extends StatefulWidget {
  final bool fromSharedPrefs;
  final int questIndex;
  final int index;

  QuizHandler(
      {@required this.fromSharedPrefs, this.questIndex, @required this.index});
  @override
  _QuizHandlerState createState() => _QuizHandlerState();
}

class _QuizHandlerState extends State<QuizHandler> {
  int questionIndex;

  @override
  void initState() {
    savingStateWhenVideoisCompletlyWatched();
    readCredentials();
    questionIndex = widget.fromSharedPrefs
        ? userLog["topic"][widget.index]["${listTopics[widget.index]["topic"]}"]
            ["quiIndexAttended"]
        : widget.questIndex;
    super.initState();
  }

  savingStateWhenVideoisCompletlyWatched() {
    userLog["topic"][widget.index]["${listTopics[widget.index]["topic"]}"]
        ["videoWatched"] = "";
    saveCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return QuizReady(
      index: widget.index,
      quesIndex: questionIndex,
    );
  }
}
