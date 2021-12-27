import 'package:flutter/material.dart';

class BookTheme {
  static bool themeMode = true;
  static Color backgroundColor = Colors.white;
  static Color textColor = Colors.black;

  static double fontSize = 18.0;

  void changeTheme() {
    if (themeMode) {
      backgroundColor = Colors.black;
      textColor = Colors.white;
      themeMode = !themeMode;
    } else {
      backgroundColor = Colors.white;
      textColor = Colors.black;
      themeMode = !themeMode;
    }
  }
}
