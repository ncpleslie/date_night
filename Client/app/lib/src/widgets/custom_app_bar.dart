import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Displays the standard AppBar that will be displayed on most/all pages.
// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  CustomAppBar({@required this.name, this.icon, this.transparent = true});

  /// The icon to display.
  Widget icon;

  /// The text to display.
  final String name;

  bool transparent;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
        title: Text(name),
        centerTitle: true,
        elevation: 0,
        backgroundColor:
            this.transparent ? Colors.transparent : Colors.deepPurple,
        toolbarOpacity: 0.7,
        actions: icon != null ? <Widget>[icon] : null);
  }
}
