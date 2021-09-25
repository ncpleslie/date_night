import 'package:date_night/config/globals.dart';
import 'package:date_night/config/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/router.gr.dart' as routes;
import 'config/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupApp();
  runApp(Phoenix(
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Globals.APP_NAME,
        theme: ThemeConfig.theme,
        initialRoute: routes.Routes.bootView,
        onGenerateRoute: routes.Router().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey);
  }
}
