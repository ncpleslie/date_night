import 'package:flutter/material.dart'
    show BuildContext, MaterialApp, StatelessWidget, Widget;
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import './config/theme_data.dart';
import './routes/route_generator.dart';
import './scoped_model/ideas_model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<IdeasModel>(
      model: IdeasModel(),
      child: MaterialApp(
        title: 'Date Night',
        theme: ThemeConfig.iOSTheme,
        onGenerateRoute: RouteGenerator.routes,
      ),
    );
  }
}
