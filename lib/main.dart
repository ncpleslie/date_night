import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:scoped_model/scoped_model.dart';

import './pages/main-pages/home_page.dart';
import './scoped-models/ideas_model.dart';
import './globals/globals.dart' as global;

void main() {
  runApp(DateNight());
}

class DateNight extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DateNightState();
  }
}

class _DateNightState extends State<DateNight> {



  @override
  Widget build(BuildContext context) {
    return ScopedModel<IdeasModel>(
        model: IdeasModel(),
        child: MaterialApp(
          title: 'Date Night',
          theme: global.iOSThemeData,
          routes: {
            '/': (BuildContext context) => HomePage(),
          },
          onGenerateRoute: (RouteSettings settings) {
            return CupertinoPageRoute<bool>(
                builder: (BuildContext context) => HomePage());
          },
          // Fallback route if unable to find correct route (Will go to main page)
          onUnknownRoute: (RouteSettings settings) {
            return CupertinoPageRoute(
                builder: (BuildContext context) => HomePage());
          },
        ));
  }
}
