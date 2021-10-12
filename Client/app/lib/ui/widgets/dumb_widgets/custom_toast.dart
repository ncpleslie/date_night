import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class CustomToast extends StatelessWidget {
  const CustomToast({required this.title, required this.message});
  final String title;
  final String message;
  @override
  Flushbar build(BuildContext context) {
    return Flushbar(
      backgroundColor: Theme.of(context).cardTheme.color!.withOpacity(0.9),
      margin: EdgeInsets.fromLTRB(8, 8, 8, 60),
      borderRadius: 8,
      titleText: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      messageText: Text(message, style: Theme.of(context).textTheme.subtitle1),
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
