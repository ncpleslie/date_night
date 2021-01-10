import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom button displayed on the add date dialog.
class DateAddDialogButton extends StatelessWidget {
  const DateAddDialogButton({this.context, this.icon, this.onTap});

  final BuildContext context;

  /// The icon to be displayed
  final IconData icon;

  /// The function to call on tap
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: Theme.of(this.context).buttonTheme.shape,
      color: Theme.of(this.context).buttonColor,
      child: Icon(icon),
      onPressed: onTap,
    );
  }
}
