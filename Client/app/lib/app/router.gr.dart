// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/views/dates_around/dates_around_view.dart';

class Routes {
  static const String datesAroundView = '/';
  static const all = <String>{
    datesAroundView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.datesAroundView, page: DatesAroundView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    DatesAroundView: (data) {
      final args = data.getArgs<DatesAroundViewArguments>(
        orElse: () => DatesAroundViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => DatesAroundView(key: args.key),
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
