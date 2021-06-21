import 'package:edgeclass/widgets.dart/appbackground.dart';
import 'package:flutter/material.dart';

class QuixHome extends StatefulWidget {
  @override
  _QuixHomeState createState() => _QuixHomeState();
}

class _QuixHomeState extends State<QuixHome> {
  @override
  Widget build(BuildContext context) {
    return ScafTile(
        widgeter: Scaffold(
            backgroundColor: Colors.transparent,
            body: backGround(Center(
              child: Text("hello lawde "),
            ))));
  }
}
