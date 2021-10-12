import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A custom floating action button element.
// ignore: must_be_immutable
class CustomFAB extends StatelessWidget {
  CustomFAB({required this.tag, required this.icon, required this.onTap, this.disabled = false}) {
  }

  /// Icon to be displayed.
  final IconData icon;

  /// Method to call when the user taps this element.
  final Function onTap;

  /// The tooltip tag this element will have.
  final String tag;

  bool disabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton(
          heroTag: tag,
          backgroundColor: disabled
              ? Theme.of(context)
                  .floatingActionButtonTheme
                  .backgroundColor!
                  .withOpacity(0.2)
              : Theme.of(context).floatingActionButtonTheme.backgroundColor!.withOpacity(1),
          elevation: Theme.of(context).floatingActionButtonTheme.elevation,
          child: Icon(
            icon,
            size: Theme.of(context).iconTheme.size,
          ),
          onPressed: disabled ? null : () => onTap,
        ),
        const SizedBox(
          height: 40.0,
        )
      ],
    );
  }
}
