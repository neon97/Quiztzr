import 'package:edgeclass/Database/Sqlite/dummyInsert.dart';
import 'package:edgeclass/Database/topics.dart';
import 'package:edgeclass/Database/userlog.dart';
import 'package:edgeclass/Model/notes.dart';
import 'package:edgeclass/constants/data.dart';
import 'package:edgeclass/constants/sharedPrefs.dart';
import 'package:edgeclass/constants/video_player/player.dart';
import 'package:edgeclass/widgets.dart/appbackground.dart';
import 'package:edgeclass/widgets.dart/appbar.dart';
import 'package:flutter/material.dart';
import 'header.dart';
import 'overview.dart';

class TopicVideoPage extends StatefulWidget {
  final int index;
  TopicVideoPage({this.index});
  @override
  _TopicVideoPageState createState() {
    return _TopicVideoPageState();
  }
}

class _TopicVideoPageState extends State<TopicVideoPage> {
  //databse
  List<Notes> noteList = [];



  @override
  void initState() {
    databaseHelper.initializeDatabase();
    !userLog["topic"][widget.index]["${listTopics[widget.index]["topic"]}"]
            ["dummyQuestion"]
        ? dummyInsert(widget.index)
        : print("");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScafTile(
        widgeter: Scaffold(
            backgroundColor: Colors.transparent,
            appBar:
                customAppBar(context, listTopics[widget.index]["topic"], false),
            body: backGround(ListView(
              children: [
                //dummy
                // AspectRatio(
                //   aspectRatio: 16 / 9.5,
                //   child: Container(
                //     color: Colors.black,
                //   ),
                // ),
                Player(
                  fileName: listTopics[widget.index]["video"],
                  index: widget.index,
                ),
                Container(
                  height: deviceHeight - deviceHeight / 2.6,
                  width: deviceWidth,
                  child: ListView(
                    children: [
//heading section && owner section
                      topicVideoHeader(
                        context,
                        listTopics[widget.index]["videoTopic"],
                        listTopics[widget.index]["creator"],
                        listTopics[widget.index]["longDescription"],
                      ),

//overview && notes
                      overViewWidget(context, setState)
                    ],
                  ),
                )
              ],
            ))));
  }
}
