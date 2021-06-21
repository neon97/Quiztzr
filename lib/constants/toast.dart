import 'package:flutter/material.dart';

void showToast(BuildContext context, String _title) {
  final scaffoldMessager = ScaffoldMessenger.of(context);
  scaffoldMessager.showSnackBar(
    SnackBar(
      content: Text(_title),
    ),
  );
}
