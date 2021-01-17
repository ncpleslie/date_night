import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

const bool LIGHT_MODE = false;

class ThemeConfig {
  static PageTransitionAnimation get pageTransition => Platform.isIOS
      ? PageTransitionAnimation.cupertino
      : PageTransitionAnimation.slideUp;

  static ThemeData get theme => LIGHT_MODE ? themeLight : themeDark;
  static List<Color> get background =>
      LIGHT_MODE ? lightBackgroundColors : darkBackgroundColors;
  static Color get primaryColor => LIGHT_MODE ? _primaryDark : _primaryLight;
  static Color get accentColor => LIGHT_MODE ? _accentDark : _accentLight;
  static Color get textColor => LIGHT_MODE ? _textDark : _textLight;

  static String get backgroundImage => LIGHT_MODE
      ? 'assets/images/background.svg'
      : 'assets/images/background_dark.svg';

  // Pill Colours
  static List<List<Color>> get pillColors => LIGHT_MODE ? _pillColorsLight : _pillColorsDark;

  static final List<List<Color>> _pillColorsLight = [
    [
      Colors.white70,
      Colors.white,
    ],
  ];

  static final List<List<Color>> _pillColorsDark = [
    [
      Colors.purple[600],
      Colors.blue[900],
    ],
  ];

  /// Light Theme
  static final Color _primaryDark = Colors.grey[900];
  static final Color _accentDark = Colors.grey[850];
  static final Color _textDark = Colors.white;

  static final Color backgroundOneLight = Colors.lightBlue[100];
  static final Color backgroundTwoLight = Colors.red[100];
  static final Color backgroundThreeLight = Colors.purple[200];

  static final List<Color> lightBackgroundColors = [
    backgroundOneLight,
    backgroundTwoLight,
    backgroundThreeLight
  ];

  /// Dark Theme
  static final Color _primaryLight = Colors.white;
  static final Color _accentLight = Colors.white54;
  static final Color _textLight = Colors.black54;

  static final Color backgroundOneDark = Colors.purple[500];
  static final Color backgroundTwoDark = Colors.purple[800];
  static final Color backgroundThreeDark = Colors.grey[900];

  static final List<Color> darkBackgroundColors = [
    backgroundOneDark,
    backgroundTwoDark,
    backgroundThreeDark
  ];

  static final ThemeData themeLight = ThemeData(
    primaryIconTheme: IconThemeData(color: _textLight, size: 24),
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
      headline2: TextStyle(
          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w300),
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
    appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
  );

  static final ThemeData themeDark = ThemeData(
    primaryIconTheme: IconThemeData(color: _textDark, size: 24),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        unselectedIconTheme: IconThemeData(color: Colors.purple[100]),
        selectedIconTheme: IconThemeData(color: Colors.purple[300])),
    backgroundColor: Colors.lightBlue[100],
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white, size: 30),
    errorColor: Colors.red,
    brightness: Brightness.light,
    primaryColor: _primaryDark,
    accentColor: _accentDark,
    buttonColor: _primaryDark,
    cardTheme: CardTheme(
      elevation: 2,
      shadowColor: Colors.white24,
      color: Colors.grey[900].withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
    ),
    dialogBackgroundColor: _accentDark,
    primaryTextTheme: TextTheme(
      subtitle1: TextStyle(color: _textDark, fontSize: 12.0),
      subtitle2: TextStyle(
          color: _textDark, fontSize: 12.0, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(color: Colors.white, fontSize: 24.0),
      bodyText2: TextStyle(
          color: _textDark, fontSize: 24.0, fontWeight: FontWeight.w300),
      headline1: TextStyle(
          color: _textDark, fontSize: 18.0, fontWeight: FontWeight.bold),
      headline2: TextStyle(
          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w300),
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
    appBarTheme: AppBarTheme(color: Colors.black, elevation: 0),
  );
}
