// routes for the app
import 'package:date_night/src/screens/plan_a_date/multi/plan_a_date_multi.dart';
import 'package:flutter/material.dart';
import '../screens/index.dart';
import '../screens/plan_a_date/multi/waiting_room.dart';
import '../screens/plan_a_date/single/plan_a_date_single.dart';
import '../screens/plan_a_date/shared/date_add.dart';
import '../screens/plan_a_date/shared/loading.dart';
import '../screens/plan_a_date/shared/results.dart';
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

      case Routes.PlanADateSingle:
        return MaterialPageRoute<bool>(builder: (_) => PlanADateSingle());

      case Routes.PlanADateMulti:
        return MaterialPageRoute<bool>(builder: (_) => PlanADateMulti());

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

      case Routes.WaitingRoom:
        return MaterialPageRoute<bool>(builder: (_) => WaitingRoom());

      default:
        return MaterialPageRoute<bool>(builder: (_) => Index());
    }
  }
}
