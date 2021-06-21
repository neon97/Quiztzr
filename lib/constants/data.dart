import 'package:edgeclass/Database/Sqlite/sql.dart';
import 'package:edgeclass/Model/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

double deviceHeight;
double deviceWidth;

Color bgColor = Color.fromRGBO(19, 22, 28, 1);

//database sqflite
DatabaseAssets databaseHelper = DatabaseAssets();

//vlc player data
VlcPlayerController vlcGlobalcontroller;
Duration vlcPlayedPosition;
List<Notes> listStopaageDurations = [];
bool showNoteOnly = true;
