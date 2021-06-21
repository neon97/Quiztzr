import 'package:edgeclass/Model/notes.dart';
import 'package:edgeclass/constants/data.dart';
import 'package:edgeclass/constants/toast.dart';
import 'package:edgeclass/constants/video_player/durationConvert.dart';
import 'package:edgeclass/screens/VideoPage/addnotes.dart';
import 'package:edgeclass/screens/VideoPage/showNotes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget overViewWidget(
    BuildContext _context, void setState(void Function() fn)) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Overview",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ),
                onPressed: () async {
                  if (vlcGlobalcontroller.value.isInitialized) {
                    vlcGlobalcontroller.pause();
                    addingNotesDialog(_context, setState);
                  } else
                    showToast(_context, "Video not working !!");
                }),
          ],
        ),
        Divider(
          color: Colors.white70,
          height: 0,
        ),
        SizedBox(
          height: 5,
        ),
        FutureBuilder(
          future: databaseHelper.getNoteList(),
          builder: (context, snap) {
            if (snap.hasData) {
              List<Notes> _listNotes = snap.data;
              listStopaageDurations = _listNotes;
              return Column(
                children: [
//stored data section with player controllers
                  for (int i = 0; i < snap.data.length; i++)
                    bulletText(_context, _listNotes[i], setState)
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        )
      ],
    ),
  );
}

Widget bulletText(
    BuildContext _context, Notes _notes, void setState(void Function() fn)) {
  Duration _videoDuration = parseDuration(_notes.duration);

  return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "➣",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
            Expanded(
              flex: 11,
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _notes.notes,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Video : ${_videoDuration.inMinutes.toString().padLeft(2, "0")}:${_videoDuration.inSeconds.toString().padLeft(2, "0")} mins",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onLongPress: () async {
        print(_notes.id);
        await databaseHelper.deleteNote(_notes.id);
        setState(() {});
      },
      onTap: () async {
        if (vlcGlobalcontroller.value.isInitialized) {
          showNoteOnly = false;
          await vlcGlobalcontroller.seekTo(_videoDuration);
          await vlcGlobalcontroller.pause();
          showingNotesDialog(
              _context, _notes.notes, parseDuration(_notes.duration), true);
        } else
          showToast(_context, "Video not working !!");
      });
}
