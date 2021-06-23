import 'package:edgeclass/Database/topics.dart';
import 'package:edgeclass/Database/userlog.dart';
import 'package:edgeclass/constants/sharedPrefs.dart';

checkAndMoveForScoreQuestionAttended(
  int quesIndex,
  int index,
  int score,
) {
  if (quesIndex == 1) {
    userLog["topic"][index]["${listTopics[index]["topic"]}"]
        ["quiIndexAttended"] = 0;
  } else {
    userLog["topic"][index]["${listTopics[index]["topic"]}"]
        ["quiIndexAttended"] = quesIndex + 1;
  }
  saveScore(index, quesIndex, score);

  saveCredentials();
}

saveScore(int index, int questionIndex, int score) {
  userLog["topic"][index]["${listTopics[index]["topic"]}"]["questions"]
      [questionIndex]["score"] = score;
}

storeQuestionState(int index, int questionIndex, double timeTaken, bool correct,
    String selected, int timeLimit) {
//timetaken
  userLog["topic"][index]["${listTopics[index]["topic"]}"]["questions"]
      [questionIndex]["timeTaken"] = timeLimit - timeTaken;

//correct submited
  userLog["topic"][index]["${listTopics[index]["topic"]}"]["questions"]
      [questionIndex]["correct"] = correct;

//selected String
  userLog["topic"][index]["${listTopics[index]["topic"]}"]["questions"]
      [questionIndex]["selected"] = selected;

  saveCredentials();
}
