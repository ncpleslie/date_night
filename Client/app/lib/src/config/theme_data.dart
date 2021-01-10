import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class ThemeConfig {
  static const Color _primary = Colors.deepPurple;
  static final Color _accent = Colors.deepPurple[300];
  static const Color _text = Colors.white;
  static ThemeData get theme => Platform.isIOS ? iOSTheme : iOSTheme;

  static final ThemeData iOSTheme = ThemeData(
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Colors.grey[900]),
      backgroundColor: Colors.purple[500],
      scaffoldBackgroundColor: Colors.grey[900],
      iconTheme: IconThemeData(color: Colors.white, size: 30),
      errorColor: Colors.red,
      brightness: Brightness.light,
      primarySwatch: _primary,
      primaryColor: _primary,
      accentColor: _accent,
      buttonColor: _primary,
      cardTheme: CardTheme(
          elevation: 10,
          shadowColor: Colors.black,
          color: _accent,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black38.withOpacity(0.2), width: 1),
            borderRadius: BorderRadius.circular(25.0),
          )),
      dialogBackgroundColor: _accent,
      primaryTextTheme: TextTheme(
        subtitle1: TextStyle(color: _text, fontSize: 12.0),
        subtitle2: TextStyle(
            color: _text, fontSize: 12.0, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(color: _text, fontSize: 24.0),
        bodyText2: TextStyle(
            color: _text, fontSize: 24.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(color: _text, fontSize: 25.0),
        headline5: TextStyle(color: _text, fontSize: 40.0),
      ),
      dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)))),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(elevation: 0, backgroundColor: _accent),
      buttonTheme: ButtonThemeData(
          buttonColor: _primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)))),
      appBarTheme: AppBarTheme(color: Colors.grey[900], elevation: 0));

  static final ThemeData androidTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    primaryColor: Colors.deepPurple,
    accentColor: Colors.deepPurple[300],
    buttonColor: CupertinoColors.activeBlue,
    dialogBackgroundColor: Colors.deepPurple[300],
  );
}
