import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: Container(
          child: Column(
        children: <Widget>[
          SizedBox(height: 100.0,),
          CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text('Change Theme'),
            onPressed: () {
              ;
            },
          ),
        ],
      )),
    );
  }
}
