import 'package:date_night/src/config/theme_data.dart';
import 'package:date_night/src/screens/plan_a_date/pick_date_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import '../routes/route_generator.dart';
import './dates_around/dates_around.dart';

/// The Index page displays the bottom navigation bar.
/// Allows the navigation to other pages while still persisting over those pages.
/// This allows the user to switch to other pages while also keep those page's state.
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

  /// Returns the bottom navigation bar
  Widget _buildTabBar() {
    return FancyBottomNavigation(
      tabs: <TabData>[
        TabData(iconData: Icons.location_city, title: 'Dates Around You'),
        TabData(iconData: Icons.people, title: 'Plan A Date'),
      ],
      circleColor:
          Theme.of(context).bottomNavigationBarTheme.selectedIconTheme.color,
      inactiveIconColor:
          Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme.color,
      initialSelection: 0,
      textColor: Theme.of(context).primaryTextTheme.subtitle1.color,
      onTabChangedListener: (int position) {
        setState(() {
          currentPage = position;
        });
      },
      barBackgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
    );
  }

  /// Returns the a page. They are stored in a stack
  /// to ensure their state is kept even when the user
  /// navigates to another page.
  Widget _getPage(MainModel model) {
    return Stack(
      children: <Offstage>[
        Offstage(
          offstage: currentPage != 0,
          child: TickerMode(
            enabled: currentPage == 0,
            child: MaterialApp(
                theme: ThemeConfig.theme,
                home: SafeArea(child: DatesAroundPage()),
                onGenerateRoute: RouteGenerator.routes),
          ),
        ),
        Offstage(
          offstage: currentPage != 1,
          child: TickerMode(
            enabled: currentPage == 1,
            child: MaterialApp(
                theme: ThemeConfig.theme,
                home: SafeArea(child: PickDateType()),
                onGenerateRoute: RouteGenerator.routes),
          ),
        ),
      ],
    );
  }
}
