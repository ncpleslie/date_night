import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './dates_around.dart';
import './date_edit.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
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
              return DatesAround();
              break;
              case 1:
              return DateEdit();
              break;
              case 2:
              return DatesAround();
              break;
              default:
              return Container();
            }
          },);
        },
      ),
    );
  }
}
