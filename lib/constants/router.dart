import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

routeTo(BuildContext _context, Widget _widgetMoveTo) {
  if (Platform.isIOS)
    Navigator.of(_context)
        .push(CupertinoPageRoute(builder: (_context) => _widgetMoveTo));
  else
    Navigator.of(_context)
        .push(MaterialPageRoute(builder: (_context) => _widgetMoveTo));
}
