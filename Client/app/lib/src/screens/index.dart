import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import '../routes/route_generator.dart';
import '../scoped_model/main_model.dart';
import './dates_around/dates_around.dart';
import './plan_a_date/plan_a_date.dart';

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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
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

  Widget _getPage(MainModel model) {
    return Stack(
      children: <Offstage>[
        Offstage(
          offstage: currentPage != 0,
          child: TickerMode(
            enabled: currentPage == 0,
            child: MaterialApp(
                home: DatesAroundPage(),
                onGenerateRoute: RouteGenerator.routes),
          ),
        ),
        Offstage(
          offstage: currentPage != 1,
          child: TickerMode(
            enabled: currentPage == 1,
            child: MaterialApp(
                home: PlanADate(), onGenerateRoute: RouteGenerator.routes),
          ),
        ),
      ],
    );
  }
}
