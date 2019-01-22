import 'package:flutter/material.dart';

import './dates_around.dart';
import './date_edit.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    DatesAround(Colors.white),
    DateEdit(),
    DatesAround(Colors.black),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Night'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: Text('Dates Around You'), icon: Icon(Icons.location_city)),
          BottomNavigationBarItem(
              title: Text('Plan A Date'), icon: Icon(Icons.people)),
          BottomNavigationBarItem(
              title: Text('Settings'), icon: Icon(Icons.settings))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
