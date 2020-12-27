import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(this.name, this.icon);

  final String name;
  final Widget icon;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
        title: Text(name),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        toolbarOpacity: 0.7,
        actions: <Widget>[icon]);
  }
}
