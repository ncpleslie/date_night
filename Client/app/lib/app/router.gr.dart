// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/views/boot/boot_view.dart';
import '../ui/views/dates_around/dates_around_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/plan_a_date/multi/waiting_room_view.dart';
import '../ui/views/plan_a_date/shared/add_date/add_date_view.dart';
import '../ui/views/plan_a_date/shared/loading/loading_view.dart';
import '../ui/views/plan_a_date/shared/results/results_view.dart';
import '../ui/views/settings/settings_view.dart';

class Routes {
  static const String bootView = '/';
  static const String homeView = '/home-view';
  static const String datesAroundView = '/dates-around-view';
  static const String settingsView = '/settings-view';
  static const String addDateView = '/add-date-view';
  static const String loadingView = '/loading-view';
  static const String resultsView = '/results-view';
  static const String waitingRoomView = '/waiting-room-view';
  static const all = <String>{
    bootView,
    homeView,
    datesAroundView,
    settingsView,
    addDateView,
    loadingView,
    resultsView,
    waitingRoomView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.bootView, page: BootView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.datesAroundView, page: DatesAroundView),
    RouteDef(Routes.settingsView, page: SettingsView),
    RouteDef(Routes.addDateView, page: AddDateView),
    RouteDef(Routes.loadingView, page: LoadingView),
    RouteDef(Routes.resultsView, page: ResultsView),
    RouteDef(Routes.waitingRoomView, page: WaitingRoomView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    BootView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const BootView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    DatesAroundView: (data) {
      final args = data.getArgs<DatesAroundViewArguments>(
        orElse: () => DatesAroundViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => DatesAroundView(key: args.key),
        settings: data,
      );
    },
    SettingsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsView(),
        settings: data,
      );
    },
    AddDateView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddDateView(),
        settings: data,
      );
    },
    LoadingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoadingView(),
        settings: data,
      );
    },
    ResultsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ResultsView(),
        settings: data,
      );
    },
    WaitingRoomView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => WaitingRoomView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// DatesAroundView arguments holder class
class DatesAroundViewArguments {
  final Key key;
  DatesAroundViewArguments({this.key});
}
