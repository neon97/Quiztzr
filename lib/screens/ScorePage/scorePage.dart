import 'package:edgeclass/Database/topics.dart';
import 'package:edgeclass/Database/userlog.dart';
import 'package:edgeclass/constants/data.dart';
import 'package:edgeclass/constants/router.dart';
import 'package:edgeclass/screens/Topics/topicMain.dart';
import 'package:edgeclass/widgets.dart/tabRow.dart';
import 'package:flutter/material.dart';

class ScorePage extends StatefulWidget {
  final int index;
  ScorePage({@required this.index});
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  String _scoreBoard;

  _calculateScore() {
    int tempScore = 0;
    for (int i = 0;
        i <
            userLog["topic"][widget.index]
                    ["${listTopics[widget.index]["topic"]}"]["questions"]
                .length;
        i++) {
      tempScore = tempScore +
          userLog["topic"][widget.index]["${listTopics[widget.index]["topic"]}"]
              ["questions"][i]["score"];
    }
    _scoreBoard = "$tempScore / 40";
  }

  @override
  void initState() {
    _calculateScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _scoreBoard,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 80),
            ),
            SizedBox(
              height: 40,
            ),
            for (int i = 0;
                i <
                    userLog["topic"][widget.index]
                                ["${listTopics[widget.index]["topic"]}"]
                            ["questions"]
                        .length;
                i++)
              showStats(i),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(31, 36, 46, 1),
                ),
                onPressed: () {
                  routeTo(context, TopicMain());
                },
                child: Text(
                  "Check Topics",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  Widget showStats(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question ${index + 1} :",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 8,
          ),
          tableRowDesign(userLog["topic"][widget.index]
              ["${listTopics[widget.index]["topic"]}"]["questions"][index]),
        ],
      ),
    );
  }
}
