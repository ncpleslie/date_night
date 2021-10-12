import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Displays the standard AppBar that will be displayed on most/all pages.
// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  CustomAppBar(
      {required this.name, this.icon, this.transparent = true, this.scrollable = false, this.isSliver = false});

  /// The icon to display.
  late Widget? icon;

  /// The text to display.
  final String name;

  /// If the background is transparent.
  bool transparent;

  /// If it will disappear on scroll
  bool scrollable;

  /// Sliver app bar.
  bool isSliver;

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverAppBar(
        title: Text(
          name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: Theme.of(context).appBarTheme.elevation,
        backgroundColor: Colors.transparent,
        actions: <Widget>[icon!],
        toolbarHeight: 22,
      );
    }
    return AppBar(
        title: Text(name, style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: Theme.of(context).appBarTheme.elevation,
        backgroundColor: this.transparent ? Colors.transparent : Theme.of(context).appBarTheme.color,
        toolbarOpacity: 0.7,
        actions: <Widget>[icon!]);
  }
}
