import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom button displayed on the add date dialog.
class DateAddDialogButton extends StatelessWidget {
  const DateAddDialogButton({this.icon, this.onTap});

  /// The icon to be displayed
  final IconData icon;

  /// The function to call on tap
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      color: Theme.of(context).primaryColor,
      child: Icon(icon),
      onPressed: onTap,
    );
  }
}
