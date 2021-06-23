import 'dart:convert';

import 'package:edgeclass/Database/userlog.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveCredentials() async {
  print("saving");
  final saved = await SharedPreferences.getInstance();
  final userLogSave = 'userLog';
  saved.setString(userLogSave, jsonEncode(userLog).toString());
}

readCredentials() async {
  print("retriving");
  final saved = await SharedPreferences.getInstance();
  final userLogRead = 'userLog';
  final result = saved.getString(userLogRead);
  if (result != null) {
    userLog = jsonDecode(result.toString());
  }

  print(userLog);
}
