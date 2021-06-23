import 'package:edgeclass/constants/data.dart';
import 'package:edgeclass/constants/router.dart';
import 'package:edgeclass/screens/QuizPage/Animations/timer.dart';
import 'package:edgeclass/screens/Topics/topicMain.dart';
import 'package:edgeclass/widgets.dart/appbackground.dart';
import 'package:flutter/material.dart';

import 'Animations/optionBoxAnimate.dart';
import 'Animations/showUp.dart';

class QuizStart extends StatefulWidget {
  final int index;
  final int quesIndex;
  QuizStart({@required this.quesIndex, @required this.index});
  @override
  _QuizStartState createState() => _QuizStartState();
}

class _QuizStartState extends State<QuizStart> {
  SizedBox _spacer = SizedBox(
    height: 10,
  );
  TextStyle _textStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        routeTo(context, TopicMain());
        return;
      },
      child: ScafTile(
          widgeter: Scaffold(
              backgroundColor: Colors.transparent,
              body: backGround(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
//header

                      Expanded(
                        flex: 1,
                        child: ShowUp(
                          child: Text(
                            listQuestions[widget.quesIndex]["data"]["metadata"]
                                    ["microConcept"][0]["label"]
                                .toString(),
                            style: _textStyle,
                            textAlign: TextAlign.center,
                          ),
                          delay: 10,
                        ),
                      ),

//show up animation

                      Expanded(
                        flex: 1,
                        child: ShowUp(
                          child: Text(
                            listQuestions[widget.quesIndex]["data"]["stimulus"]
                                .toString(),
                            style: _textStyle,
                            textAlign: TextAlign.center,
                          ),
                          delay: 10,
                        ),
                      ),

                      _spacer,

//circularProgressIndicatio
                      TimerTimeout(
                        index: widget.index,
                        questionIndex: widget.quesIndex,
                        timer: double.parse(listQuestions[widget.quesIndex]
                                ["data"]["metadata"]["duration"]
                            .toString()),
                      ),

                      _spacer,

//options
                      Expanded(
                          flex: 5,
                          child: GridView.count(
                            mainAxisSpacing: 25,
                            crossAxisSpacing: 25,
                            crossAxisCount: 2,
                            children: [
                              for (int i = 0; i < 4; i++)
                                OptionAnimate(
                                  limitTimer: int.parse(
                                      listQuestions[widget.quesIndex]["data"]
                                              ["metadata"]["duration"]
                                          .toString()),
                                  selectedString:
                                      listQuestions[widget.quesIndex]["data"]
                                              ["options"][i]["label"]
                                          .toString(),
                                  index: widget.index,
                                  quesIndex: widget.quesIndex,
                                  isCorrect: listQuestions[widget.quesIndex]
                                      ["data"]["options"][i]["isCorrect"],
                                  score: listQuestions[widget.quesIndex]["data"]
                                      ["options"][i]["score"],
                                  delay: i * 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 20,
                                        backgroundColor: bgColor,
                                        child: Text(
                                          listQuestions[widget.quesIndex]
                                                      ["data"]["options"][i]
                                                  ["value"]
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        listQuestions[widget.quesIndex]["data"]
                                                ["options"][i]["label"]
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  EdgeInsets.fromLTRB(30, 50, 30, 0)))),
    );
  }
}
