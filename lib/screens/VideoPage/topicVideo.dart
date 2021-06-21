import 'package:edgeclass/Database/topics.dart';
import 'package:edgeclass/Model/notes.dart';
import 'package:edgeclass/constants/data.dart';
import 'package:edgeclass/constants/video_player/player.dart';
import 'package:edgeclass/widgets.dart/appbar.dart';
import 'package:edgeclass/widgets.dart/appbackground.dart';
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

  dummyInsert() async {
    await databaseHelper.insertNote(Notes(
        notes:
            "The first Game that was developed in 1962 was a colorful Blocks game.",
        duration: Duration(seconds: 4).toString()));
    await databaseHelper.insertNote(Notes(
        notes:
            "This following game was developed by Charle Henry and Edward Frendz",
        duration: Duration(seconds: 10).toString()));
    await databaseHelper.insertNote(Notes(
        notes:
            "This was the beginning Era for the games following with Mario, Sonic & other favorable games too.",
        duration: Duration(seconds: 20).toString()));
  }

  @override
  void initState() {
    databaseHelper.initializeDatabase();
    // dummyInsert();
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
