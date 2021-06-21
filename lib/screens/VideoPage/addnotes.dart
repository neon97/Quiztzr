import 'package:edgeclass/Model/notes.dart';
import 'package:edgeclass/constants/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

addingNotesDialog(BuildContext context, void setState(void Function() fn)) {
  final _controller = TextEditingController();
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, stateSet) {
            return AlertDialog(
              backgroundColor: bgColor,
              actions: [
                TextButton(
                    onPressed: () {
                      _controller.text.isEmpty
                          ? print("")
                          : _addNotes(context, _controller.text, setState);
                    },
                    child: Text(
                      "SAVE NOTE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _controller.text.isEmpty
                              ? Colors.grey[400]
                              : Colors.white),
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
                  Text("Create Note",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
              content: TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  stateSet(() {});
                },
                controller: _controller,
                maxLines: 8,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  hintText: 'Add Notes',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
            );
          }));
}

_addNotes(BuildContext _context, String note,
    void setState(void Function() fn)) async {
  await databaseHelper
      .insertNote(Notes(notes: note, duration: vlcPlayedPosition.toString()));
  setState(() {});
  Navigator.pop(_context);
  await vlcGlobalcontroller.play();
}
