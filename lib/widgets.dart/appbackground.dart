import 'package:edgeclass/constants/data.dart';
import 'package:flutter/material.dart';

class ScafTile extends StatelessWidget {
  final Widget widgeter;

  ScafTile({
    this.widgeter,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(children: [
      Container(
        color: bgColor,
        height: height,
        width: width,
      ),
      widgeter
    ]));
  }
}

Widget backGround(Widget _widget, [EdgeInsetsGeometry _padding]) {
  return Container(
    padding: _padding ?? EdgeInsets.all(0),
    height: deviceHeight,
    width: deviceWidth,
    child: _widget,
  );
}
