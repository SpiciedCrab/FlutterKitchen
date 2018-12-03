import 'package:flutter/material.dart';

class Margins {
  static const double normal = 16.0;
  static const double smaller = 12.0;
  static const double min = 8.0;
}

class TextThemes  {
  static TextStyle titleStyle = new TextStyle(
      fontSize: 30.0,
      color: Colors.black87,
      fontWeight: FontWeight.bold
  );

  static const double titleLeft = Margins.normal;

  static TextStyle highlightStyle = new TextStyle(
      fontSize: 24.0,
      color: Colors.black87,
      fontWeight: FontWeight.bold
  );

  static TextStyle lightHighlightStyle = new TextStyle(
      fontSize: 20.0,
      color: Colors.white,
      fontWeight: FontWeight.bold
  );

  static TextStyle contentStyle = new TextStyle(
    fontSize: 14.0,
    color: Colors.grey,
  );

  static TextStyle inputStyle = new TextStyle(
    fontSize: 18.0,
    color: Colors.black87,
  );
}

class CardThemes {
  static const EdgeInsets cardPadding = const EdgeInsets.only(
      left: Margins.normal, right: Margins.normal, top: Margins.min);
}