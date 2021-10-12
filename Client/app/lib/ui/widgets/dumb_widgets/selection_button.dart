import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Creates a large, half-screen selection button.
/// This button can be used on the "Plan a date" page to
/// bring the user to a "date add" page.
/// The button will change color and become disabled if the user
/// should no longer use this button.
class SelectionButton extends StatelessWidget {
  const SelectionButton(
      {required this.context,
      required this.text,
      required this.disabled,
      required this.onTap});

  /// BuildContext of the parent Widget
  final BuildContext context;

  /// Whether the button should be disabled.
  final bool disabled;

  /// The function to call when the button is tapped.
  final Function onTap;

  /// The text to display on the button.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        textStyle: TextStyle(
            color: Theme.of(context).primaryTextTheme.headline6!.color),
        color: disabled ? Colors.red : Colors.greenAccent[700],
        child: InkWell(
          onTap: disabled ? null : () => onTap,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                disabled
                    ? Icon(
                        Icons.person_add_disabled,
                        color: Theme.of(context).iconTheme.color,
                      )
                    : Icon(
                        Icons.person_add,
                        color: Theme.of(context).iconTheme.color,
                      ),
                Text(
                  text,
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
