import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import './dates_around.dart';
import './date_edit.dart';
import './settings.dart';
import '../scoped-models/ideas_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, IdeasModel model) {
      return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                title: Text('Dates Around You'),
                icon: Icon(Icons.location_city)),
            BottomNavigationBarItem(
                title: Text('Plan A Date'), icon: Icon(Icons.people)),
            BottomNavigationBarItem(
                title: Text('Settings'), icon: Icon(Icons.settings))
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(builder: (BuildContext context) {
            switch (index) {
              case 0:
              return DatesAroundPage(model);
              break;
              case 1:
              return DateEdit();
              break;
              case 2:
              return Settings();
              break;
              default:
              return Container();
            }
          },);
        },
      ),
    );
    },);
    
  }
}
