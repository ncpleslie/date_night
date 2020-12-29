import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A custom floating action button element.
class CustomFAB extends StatelessWidget {
  const CustomFAB(
      {@required this.tag, @required this.icon, @required this.onTap});

  /// Icon to be displayed.
  final IconData icon;

  /// Method to call when the user taps this element.
  final Function onTap;

  /// The tooltip tag this element will have.
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton(
          heroTag: tag,
          backgroundColor: CupertinoColors.activeBlue,
          elevation: 0,
          child: Icon(
            icon,
            size: 30,
          ),
          onPressed: onTap,
        ),
        const SizedBox(
          height: 40.0,
        )
      ],
    );
  }
}
