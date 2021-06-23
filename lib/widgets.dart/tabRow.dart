import 'package:edgeclass/constants/textCasing.dart';
import 'package:flutter/material.dart';

Widget tableRowDesign(
  Map<String, dynamic> tabledata,
) {
  return Container(
    decoration: BoxDecoration(
        color: Color.fromRGBO(31, 36, 46, 1),
        borderRadius: BorderRadius.circular(10)),
    child: Table(
      border: TableBorder(horizontalInside: BorderSide(color: Colors.white30)),
      children: [
        for (int i = 0; i < tabledata.length; i++)
          _tableRow(
            tabledata.keys.elementAt(i),
            tabledata.values.elementAt(i),
          ),
      ],
    ),
  );
}

TableRow _tableRow(
  String title,
  dynamic subtitle,
) {
  return TableRow(children: [
    Padding(
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          firstUppercase(title),
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    ),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          subtitle == null ? "-" : subtitle.toString(),
          style: TextStyle(fontSize: 12, color: Colors.white),
        )),
  ]);
}
