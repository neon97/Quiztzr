import 'package:edgeclass/Model/notes.dart';
import 'package:edgeclass/constants/data.dart';
import 'package:edgeclass/constants/sharedPrefs.dart';

import '../topics.dart';
import '../userlog.dart';

dummyInsert(int index) async {
  switch (listTopics[index]["topic"]) {
    case "Games":
      await databaseHelper.insertNote(Notes(
          notes:
              "The first Game that was developed in 1962 was a colorful Blocks game.",
          duration: Duration(seconds: 8).toString()));
      break;

    case "Science":
      await databaseHelper.insertNote(Notes(
          notes:
              "Sir Isaac Newton was the only one, who thinked why the apple went downward?",
          duration: Duration(seconds: 18).toString()));
      break;

    case "History":
      await databaseHelper.insertNote(Notes(
          notes:
              "The Main war in World War II was between America & Japan",
          duration: Duration(seconds: 20).toString()));
      break;
    case "Maths":
      await databaseHelper.insertNote(Notes(
          notes:
              "Phythagoras is the one which has the smallest Theorem to proof.",
          duration: Duration(seconds: 32).toString()));
      break;
    default:
  }

  userLog["topic"][index]["${listTopics[index]["topic"]}"]["dummyQuestion"] =
      true;
  saveCredentials();
}
