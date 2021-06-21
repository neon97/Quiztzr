import 'package:edgeclass/constants/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

showingNotesDialog(BuildContext context, String _savedNotes, Duration _seekTo) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, stateSet) {
            return AlertDialog(
              backgroundColor: bgColor,
              actions: [
                TextButton(
                    onPressed: () async {
                      await vlcGlobalcontroller
                          .seekTo(Duration(seconds: _seekTo.inSeconds + 2));
                      Navigator.pop(context);
                      vlcGlobalcontroller.play();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ))
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Row(
                children: [
                  Icon(
                    Entypo.book,
                    size: 25,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Saved Notes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
              content: Text(
                _savedNotes,
                style: TextStyle(color: Colors.white70),
              ),
            );
          }));
}
