// routes for the app
import 'package:flutter/material.dart';
import '../screens/index.dart';
import '../screens/plan_a_date/date_add.dart';
import '../screens/plan_a_date/loading.dart';
import '../screens/plan_a_date/results.dart';
import '../screens/settings/settings.dart';
import './routes.dart';

// ignore: avoid_classes_with_only_static_members
class RouteGenerator {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.Index:
        return MaterialPageRoute<bool>(builder: (_) => Index());
      case Routes.DateAdd:
        return MaterialPageRoute<bool>(builder: (_) => DateAdd());
      case Routes.Results:
        return MaterialPageRoute<bool>(
          builder: (_) => Results(),
          fullscreenDialog: true,
        );
      case Routes.Loading:
        return MaterialPageRoute<bool>(builder: (_) => Loading());
      case Routes.Settings:
        return MaterialPageRoute<bool>(
          builder: (_) => Settings(),
          fullscreenDialog: true,
        );
      default:
        return MaterialPageRoute<bool>(builder: (_) => Index());
    }
  }
}
