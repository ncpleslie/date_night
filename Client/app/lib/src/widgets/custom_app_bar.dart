import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

/// Displays the standard AppBar that will be displayed on most/all pages.
// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  CustomAppBar(
      {@required this.name,
      this.icon,
      this.transparent = true,
      this.scrollable = false,
      this.scrollController});

  /// The icon to display.
  Widget icon;

  /// The text to display.
  final String name;

  /// If the background is transparent.
  bool transparent;

  /// If it will disappear on scroll
  bool scrollable;

  /// Scrollable controller.
  ScrollController scrollController;

  @override
  PreferredSizeWidget build(BuildContext context) {
    if (scrollable && scrollController != null) {
      return ScrollAppBar(
          controller: scrollController,
          title: Text(
            name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: Theme.of(context).appBarTheme.elevation,
          backgroundColor: Colors.transparent,
          toolbarOpacity: 0.7,
          materialType: MaterialType.transparency,
          actions: icon != null ? <Widget>[icon] : null);
    }
    return AppBar(
        title: Text(name, style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: Theme.of(context).appBarTheme.elevation,
        backgroundColor: this.transparent
            ? Colors.transparent
            : Theme.of(context).appBarTheme.color,
        toolbarOpacity: 0.7,
        actions: icon != null ? <Widget>[icon] : null);
  }
}
