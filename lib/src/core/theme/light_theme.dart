import 'package:flutter/material.dart';

Color lightPrimaryColor = Colors.grey.shade200;

Color lightSecondaryColor = Colors.white;

ThemeData lightTheme = ThemeData(
  cardColor: Colors.grey.shade300,
  scaffoldBackgroundColor: lightPrimaryColor,
  colorScheme: ColorScheme.light(
      primary: lightPrimaryColor, secondary: lightSecondaryColor),
  cardTheme: CardTheme(
    shadowColor: Colors.grey.shade500,
    color: Colors.grey.shade500,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.blue.shade800,
    ),
    titleMedium: TextStyle(
      color: Colors.grey.shade800,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: lightSecondaryColor,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(30),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
);
