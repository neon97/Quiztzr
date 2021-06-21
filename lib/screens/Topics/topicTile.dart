import 'package:edgeclass/Database/topics.dart';
import 'package:edgeclass/constants/data.dart';
import 'package:flutter/material.dart';

Widget topicTile(BuildContext _context, int _index) {
  double _padforOdd = 50.0;
  return Padding(
    padding: EdgeInsets.only(
        top: _index == 1 ? _padforOdd : 0,
        bottom: _index.isOdd && _index != 1 ? _padforOdd : 0),
    child: Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(31, 36, 46, 1),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Stack(
        children: [
//upper icon, color container
          Align(
            alignment: Alignment.topRight,
            child: Container(
              alignment: Alignment.topCenter,
              height: deviceWidth / 2 - 70,
              width: deviceWidth / 2 - 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(listTopics[_index]["icon"],
                    size: 45, color: Colors.white70),
              ),
            ),
          ),
//title and its info
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 65, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    listTopics[_index]["topic"],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white70),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    listTopics[_index]["description"],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70
                    ),
                  )
                ],
              ),
            ),
          ),

//lower color continer
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: deviceWidth / 2 - 90,
              width: deviceWidth / 2 - 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white70.withOpacity(0.1),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
