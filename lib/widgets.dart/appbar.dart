import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customAppBar(BuildContext _context, String _title, [bool _main]) {
  return AppBar(
    brightness: Brightness.dark,
    leading: IconButton(
        icon: _main
            ? Image(
                image: AssetImage("assets/nav.png"),
                height: 27,
                color: Colors.white,
              )
            : Icon(CupertinoIcons.back),
        onPressed: () {
          _main ? print("") : Navigator.pop(_context);
        }),
    title: Text(
      _title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
          padding: EdgeInsets.all(5),
          icon: CircleAvatar(
            maxRadius: 20,
            backgroundImage: AssetImage("assets/self.png"),
          ),
          onPressed: () {}),
      SizedBox(
        width: 15,
      ),
    ],
    centerTitle: true,
    elevation: 0.0,
    backgroundColor: Colors.transparent,
  );
}
