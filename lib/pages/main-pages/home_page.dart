import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import './dates_around.dart';
import './date_edit.dart';
import './settings.dart';
import '../../scoped-models/ideas_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        return Scaffold(
          body: _getPage(model),
          resizeToAvoidBottomPadding: false,
          bottomNavigationBar: _buildTabBar(),
        );
      },
    );
  }

  Widget _buildTabBar() {
    return FancyBottomNavigation(
      tabs: <TabData>[
        TabData(iconData: Icons.location_city, title: 'Dates Around You'),
        TabData(iconData: Icons.people, title: 'Plan A Date'),
        TabData(iconData: Icons.settings, title: 'Settings'),
      ],
      circleColor: Theme.of(context).accentColor,
      inactiveIconColor: Theme.of(context).accentColor,
      initialSelection: 0,
      textColor: Colors.white,
      onTabChangedListener: (position) {
        setState(() {
          currentPage = position;
        });
      },
      barBackgroundColor: Colors.deepPurple,
    );
  }

  _getPage(model) {
    return Stack(
      children: [
        Offstage(
          offstage: currentPage != 0,
          child: TickerMode(
            enabled: currentPage == 0,
            child: MaterialApp(
              home: DatesAroundPage(model),
            ),
          ),
        ),
        Offstage(
          offstage: currentPage != 1,
          child: TickerMode(
            enabled: currentPage == 1,
            child: MaterialApp(
              home: DateEdit(),
            ),
          ),
        ),
        Offstage(
          offstage: currentPage != 2,
          child: TickerMode(
            enabled: currentPage == 2,
            child: MaterialApp(
              home: Settings(),
            ),
          ),
        )
      ],
    );
  }
}
