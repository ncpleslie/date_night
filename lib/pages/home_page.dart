import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

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
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        return Scaffold(
          body: Container(
            child: Center(
              child: _getPage(currentPage, model),
            ),
          ),
          resizeToAvoidBottomPadding: false,
          bottomNavigationBar: _buildTabBar(),
        );
      },
    );
  }

  Widget _buildTabBar() {
    return FancyBottomNavigation(
      tabs: <TabData>[
        TabData(
            iconData: Icons.location_city,
            title: 'Dates Around You',
            onclick: () {
              final FancyBottomNavigationState fState =
                  bottomNavigationKey.currentState;
              fState.setPage(2);
            }),
        TabData(iconData: Icons.people, title: 'Plan A Date'),
        TabData(iconData: Icons.settings, title: 'Settings'),
      ],
      circleColor: Theme.of(context).accentColor,
      inactiveIconColor: Theme.of(context).accentColor,
      initialSelection: 0,
      key: bottomNavigationKey,
      onTabChangedListener: (position) {
        setState(() {
          currentPage = position;
        });
      },
      barBackgroundColor: Colors.deepPurple,
    );
  }

  _getPage(int page, model) {
    switch (page) {
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
  }
}
