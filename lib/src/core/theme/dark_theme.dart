import 'package:flutter/material.dart';

Color darkPrimaryColor = Colors.grey.shade900;

Color darkSecondaryColor = Colors.grey.shade800;

ThemeData darkTheme = ThemeData(
  cardColor: Colors.grey.shade700,
  scaffoldBackgroundColor: darkPrimaryColor,
  colorScheme: ColorScheme.dark(
      primary: darkPrimaryColor, secondary: darkSecondaryColor),
  iconTheme: const IconThemeData(color: Colors.white),
  cardTheme: CardTheme(
    shadowColor: darkPrimaryColor,
    color: darkPrimaryColor,
  ),
  textTheme: TextTheme(
    titleLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      color: Colors.grey.shade300,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: darkSecondaryColor,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(30),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
);
