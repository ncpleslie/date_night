import 'package:date_night/ui/views/dates_around/dates_around_view.dart';
import 'package:date_night/ui/views/plan_a_date/multi/plan_a_date_multi_view.dart';
import 'package:date_night/ui/views/plan_a_date/single/plan_a_date_single_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

/// The Home page displays the bottom navigation bar.
/// Allows the navigation to other pages while still persisting over those pages.
/// This allows the user to switch to other pages while also keep those page's state.
class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  PersistentTabController _controller;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _buildTabBar(context),
      );

  Widget _buildTabBar(BuildContext context) {
    return PersistentTabView(
      context,
      padding: NavBarPadding.symmetric(vertical: 10),
      controller: _controller,
      screens: _getPage(),
      items: _getTabIcons(),
      backgroundColor: Theme.of(context).appBarTheme.color,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.transparent,
        adjustScreenBottomPaddingOnCurve: true,
      ),
      navBarStyle: NavBarStyle.style3,
      handleAndroidBackButtonPress: true,
      confineInSafeArea: true,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 800),
        curve: Curves.bounceOut,
      ),
    );
  }

  /// Returns the bottom navigation bar
  List<PersistentBottomNavBarItem> _getTabIcons() {
    return [
      PersistentBottomNavBarItem(
          icon: FaIcon(FontAwesomeIcons.globeAmericas),
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
      DatesAroundView(),
      PlanADateSingleView(),
      PlanADateMultiView(),
    ];
  }
}
