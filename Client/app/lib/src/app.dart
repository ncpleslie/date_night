import 'package:date_night/src/routes/route_generator.dart';
import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/screens/boot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show BuildContext, MaterialApp, StatelessWidget, Widget;
import 'package:model/main.dart';
import 'package:scoped_model/scoped_model.dart';

import './config/theme_data.dart';

/// This is not the main App.
/// All changes here will have no effect
/// on the application.
/// Navigate to "index.dart" if changes
/// need to be made.
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        title: 'Date Night',
        theme: ThemeConfig.theme,
        onGenerateRoute: RouteGenerator.routes,
        routes: <String, WidgetBuilder>{
          Routes.Index: (BuildContext context) => Boot(),
        },
      ),
    );
  }
}
