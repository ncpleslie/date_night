import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import '../scoped_model/ideas_model.dart';
import './date_edit/date_edit.dart';
import './dates_around/dates_around.dart';

class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexState();
  }
}

class _IndexState extends State<Index> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IdeasModel>(
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
      ],
      circleColor: Theme.of(context).accentColor,
      inactiveIconColor: Theme.of(context).accentColor,
      initialSelection: 0,
      textColor: Colors.white,
      onTabChangedListener: (int position) {
        setState(() {
          currentPage = position;
        });
      },
      barBackgroundColor: Colors.deepPurple,
    );
  }

  Widget _getPage(IdeasModel model) {
    return Stack(
      children: <Offstage>[
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
      ],
    );
  }
}
