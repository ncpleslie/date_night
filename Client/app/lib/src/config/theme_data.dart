import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class ThemeConfig {
  static ThemeData get theme => Platform.isIOS ? iOSThemeLight : iOSThemeLight;

  /// Light Theme
  static final Color _primaryDark = Colors.deepPurple;
  static final Color _accentDark = Colors.deepPurple[300];
  static final Color _textDark = Colors.white;

  static final Color backgroundOneLight = Colors.lightBlue[100];
  static final Color backgroundTwoLight = Colors.red[100];
  static final Color backgroundThreeLight = Colors.purple[200];

  /// Dark Theme
  static final Color _primaryLight = Colors.white;
  static final Color _accentLight = Colors.white54;
  static final Color _textLight = Colors.black54;

  static final Color backgroundOneDark = Colors.purple[500];
  static final Color backgroundTwoDark = Colors.purple[800];
  static final Color backgroundThreeDark = Colors.grey[900];

  static final ThemeData iOSThemeLight = ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          unselectedIconTheme: IconThemeData(color: Colors.purple[100]),
          selectedIconTheme: IconThemeData(color: Colors.purple[300])),
      backgroundColor: Colors.lightBlue[100],
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white, size: 30),
      errorColor: Colors.red,
      brightness: Brightness.light,
      primaryColor: _primaryLight,
      accentColor: _accentLight,
      buttonColor: _primaryLight,
      cardTheme: CardTheme(
        elevation: 10,
        shadowColor: Colors.black38,
        color: Colors.white.withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      dialogBackgroundColor: _accentLight,
      primaryTextTheme: TextTheme(
        subtitle1: TextStyle(color: _textLight, fontSize: 12.0),
        subtitle2: TextStyle(
            color: _textLight, fontSize: 12.0, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(color: Colors.black, fontSize: 24.0),
        bodyText2: TextStyle(
            color: _textLight, fontSize: 24.0, fontWeight: FontWeight.w300),
        headline1: TextStyle(
            color: _textLight, fontSize: 18.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(color: _textLight, fontSize: 25.0),
        headline5: TextStyle(color: _textLight, fontSize: 40.0),
      ),
      dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)))),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0, backgroundColor: _accentLight),
      buttonTheme: ButtonThemeData(
          buttonColor: _primaryLight,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)))),
      appBarTheme: AppBarTheme(color: Colors.white, elevation: 0));

  static final ThemeData iOSThemeDark = ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[900],
          unselectedIconTheme: IconThemeData(color: Colors.purple[100]),
          selectedIconTheme: IconThemeData(color: Colors.purple[300])),
      backgroundColor: Colors.purple[500],
      scaffoldBackgroundColor: Colors.grey[900],
      iconTheme: IconThemeData(color: Colors.white, size: 30),
      errorColor: Colors.red,
      brightness: Brightness.light,
      primaryColor: _primaryDark,
      accentColor: _accentDark,
      buttonColor: _primaryDark,
      cardTheme: CardTheme(
          elevation: 10,
          shadowColor: Colors.black,
          color: _accentDark,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black38.withOpacity(0.2), width: 1),
            borderRadius: BorderRadius.circular(25.0),
          )),
      dialogBackgroundColor: _accentDark,
      primaryTextTheme: TextTheme(
        subtitle1: TextStyle(color: _textDark, fontSize: 12.0),
        subtitle2: TextStyle(
            color: _textDark, fontSize: 12.0, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(color: _textDark, fontSize: 24.0),
        bodyText2: TextStyle(
            color: _textDark, fontSize: 24.0, fontWeight: FontWeight.w300),
        headline6: TextStyle(color: _textDark, fontSize: 25.0),
        headline5: TextStyle(color: _textDark, fontSize: 40.0),
      ),
      dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)))),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0, backgroundColor: _accentDark),
      buttonTheme: ButtonThemeData(
          buttonColor: _primaryDark,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)))),
      appBarTheme: AppBarTheme(color: Colors.grey[900], elevation: 0));
}
