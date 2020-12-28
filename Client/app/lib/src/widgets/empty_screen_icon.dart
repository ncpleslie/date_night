import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyScreenIcon extends StatelessWidget {
  const EmptyScreenIcon(this.text, this.icon);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: Colors.white),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
