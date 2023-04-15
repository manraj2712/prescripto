import 'package:flutter/material.dart';

abstract class MyFontStyles {
  static const heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: "Muli",
    color: Colors.black,
  );
  static const heading2 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: "Muli");
  static const heading3 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontFamily: "Muli");
  static const heading4 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontFamily: "Muli");
  static const heading5 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
      fontFamily: "Muli");
  static const errorText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.red,
    fontFamily: "Muli",
  );
  static const listTitleText = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w900,
      color: Colors.black,
      fontFamily: 'Muli');
  static const ListSubtitleHead = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: 'Muli');
}
