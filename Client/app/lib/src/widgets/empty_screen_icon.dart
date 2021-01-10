import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Creates an icon that can be displayed in the background of
/// empty screens.
class EmptyScreenIcon extends StatelessWidget {
  const EmptyScreenIcon(this.text, this.icon);

  /// The text to show the user.
  final String text;

  /// An icon to show the user.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(icon,
            color: Theme.of(context).iconTheme.color,
            size: Theme.of(context).iconTheme.size),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).primaryTextTheme.subtitle1,
        )
      ],
    );
  }
}
