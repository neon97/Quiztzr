import 'package:edgeclass/Database/topics.dart';
import 'package:edgeclass/constants/router.dart';
import 'package:edgeclass/screens/QuizPage/quizHandler.dart';
import 'package:edgeclass/screens/Topics/topicTile.dart';
import 'package:edgeclass/screens/VideoPage/topicVideo.dart';
import 'package:edgeclass/widgets.dart/appbackground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../widgets.dart/appbar.dart';

class TopicMain extends StatefulWidget {
  @override
  _TopicMainState createState() => _TopicMainState();
}

class _TopicMainState extends State<TopicMain> {
  ScrollPhysics physics;
  @override
  Widget build(BuildContext context) {
    return ScafTile(
        widgeter: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: customAppBar(context, "Quiztrz", true),
      body: backGround(
          ListView(
            physics: physics,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  "Choose Your\nTopic.",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(parent: physics),
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  itemCount: listTopics.length,
                  itemBuilder: (_context, index) {
                    return GestureDetector(
                      child: topicTile(_context, index),
                      onTap: () {
                        routeTo(
                            context,
                            TopicVideoPage(
                              index: index,
                            ));
                      },
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.2 : 1.48);
                  })
            ],
          ),
          EdgeInsets.symmetric(horizontal: 25)),
    ));
  }
}
