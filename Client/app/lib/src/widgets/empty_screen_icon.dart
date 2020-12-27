import 'package:flutter/cupertino.dart';

class EmptyScreenIcon extends StatelessWidget {
  const EmptyScreenIcon(this.text, this.icon);

  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[icon, Text(text, textAlign: TextAlign.center)],
    );
  }
}
