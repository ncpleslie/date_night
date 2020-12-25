// routes for the app
import 'package:flutter/material.dart';
import '../screens/index.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute<bool>(builder: (_) => Index());
    default:
      return MaterialPageRoute<bool>(builder: (_) => Index());
  }
}
