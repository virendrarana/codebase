import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.indigo,
  hintColor: Colors.amber,
  textTheme: TextTheme(
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
  ),
  appBarTheme: AppBarTheme(elevation: 4, centerTitle: true),
);
