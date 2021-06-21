import 'dart:ui';
import 'package:edgeclass/screens/VideoPage/details.dart';
import 'package:flutter/material.dart';

Widget topicVideoHeader(BuildContext _context, String _videoTitle,
    String _videoOwner, String _description) {
  return Padding(
    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//video title
              Text(
                _videoTitle,
                style: TextStyle(color: Colors.white, fontSize: 19.5),
              ),

//video maker name
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  _videoOwner,
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 8,
        ),

//show details icons
        Expanded(
          flex: 1,
          child: IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                showDetails(_context, _description);
              }),
        ),
      ],
    ),
  );
}
