import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ThemeConfig {
  static ThemeData get iOSTheme => ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.deepPurple,
      primaryColor: Colors.deepPurple,
      accentColor: Colors.deepPurple[300],
      buttonColor: CupertinoColors.activeBlue,
      dialogBackgroundColor: Colors.deepPurple[300],
      );
}
