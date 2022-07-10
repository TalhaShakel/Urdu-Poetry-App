import 'package:flutter/material.dart';

const double kToolbarHeight = 56.0;
Color kcolor = Color.fromARGB(255, 7, 73, 206);
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
