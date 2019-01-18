import 'package:flutter/material.dart';

import './pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final ThemeData _iOSThemeData = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.grey,
    accentColor: Colors.blue,
    buttonColor: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Night',
      theme: _iOSThemeData,
      routes: {
        '/': (BuildContext context) => HomePage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<bool>(
            builder: (BuildContext context) => HomePage());
      },
      // Fallback route if unable to find correct route (Will go to main page)
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => HomePage());
      },
    );
  }
}
