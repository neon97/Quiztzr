import 'package:edgeclass/constants/data.dart';
import 'package:flutter/material.dart';

showDetails(BuildContext _context, String _description) {
  showModalBottomSheet(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      context: _context,
      builder: (_context) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          height: deviceHeight / 2,
          width: deviceWidth,
          child: Column(
            children: [
//handle
              Container(
                height: 10.0,
                width: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[400],
                ),
              ),

//description Text
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("Description",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),

//description
              Text(
                _description,
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.left,
              )
            ],
          ),
        );
      });
}
