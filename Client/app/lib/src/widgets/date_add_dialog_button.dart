import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom button displayed on the add date dialog.
class DateAddDialogButton extends StatelessWidget {
  const DateAddDialogButton(this.context, {this.icon, this.onTap});

  final BuildContext context;

  /// The icon to be displayed
  final IconData icon;

  /// The function to call on tap
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final double buttonSize = 35;
    return Card(
      elevation: Theme.of(this.context).cardTheme.elevation,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration:
            BoxDecoration(color: Colors.white12, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: InkWell(
          customBorder: new CircleBorder(),
          splashColor: Colors.black26,
          onTap: onTap,
          onTapDown: (TapDownDetails details) {},
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
                maxHeight: buttonSize,
                maxWidth: buttonSize,
                minHeight: buttonSize,
                minWidth: buttonSize),
            padding: EdgeInsets.all(0),
            child: Icon(
              icon,
              size: Theme.of(this.context).primaryIconTheme.size,
              color: Theme.of(this.context).primaryIconTheme.color,
            ),
          ),
        ),
      ),
    );
  }
}
