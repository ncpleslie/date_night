import 'package:date_night/src/config/theme_data.dart';
import 'package:date_night/src/screens/plan_a_date/multi/plan_a_date_multi.dart';
import 'package:date_night/src/screens/plan_a_date/single/plan_a_date_single.dart';
import 'package:date_night/ui/views/dates_around/dates_around_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:model/main.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:scoped_model/scoped_model.dart';

import '../routes/route_generator.dart';

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
  PersistentTabController _controller;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          body: _buildTabBar(context),
          resizeToAvoidBottomPadding: false,
        );
      },
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return PersistentTabView(
      context,
      padding: NavBarPadding.symmetric(vertical: 10),
      controller: _controller,
      screens: _getPage(),
      items: _getTabIcons(),
      backgroundColor: Theme.of(context).appBarTheme.color,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        colorBehindNavBar: Colors.transparent,
        adjustScreenBottomPaddingOnCurve: true,
      ),
      navBarStyle: NavBarStyle.style3,
      handleAndroidBackButtonPress: true,
      confineInSafeArea: true,
      // itemAnimationProperties: ItemAnimationProperties(
      //   // Navigation Bar's items animation properties.
      //   duration: Duration(milliseconds: 200),
      //   curve: Curves.ease,
      // ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
    );
  }

  /// Returns the bottom navigation bar
  List<PersistentBottomNavBarItem> _getTabIcons() {
    return [
      PersistentBottomNavBarItem(
          icon: FaIcon(FontAwesomeIcons.city),
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          opacity: 0.3),
      PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.male),
        activeColor: Colors.teal,
        inactiveColor: Colors.grey,
        opacity: 0.7,
      ),
      PersistentBottomNavBarItem(
          icon: FaIcon(FontAwesomeIcons.peopleArrows),
          activeColor: Colors.purple,
          inactiveColor: Colors.grey,
          opacity: 0.3),
    ];
  }

  /// Returns the tab pages
  List<Widget> _getPage() {
    return [
      MaterialApp(
          theme: ThemeConfig.theme,
          home: SafeArea(child: DatesAroundView()),
          onGenerateRoute: RouteGenerator.routes),
      MaterialApp(
          theme: ThemeConfig.theme,
          home: SafeArea(child: PlanADateSingle()),
          onGenerateRoute: RouteGenerator.routes),
      MaterialApp(
          theme: ThemeConfig.theme,
          home: SafeArea(child: PlanADateMulti()),
          onGenerateRoute: RouteGenerator.routes),
    ];
  }
}
