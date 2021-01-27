import 'package:date_night/app/locator.dart';
import 'package:date_night/src/config/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/router.gr.dart' as routes;

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(
    child: App(),
  ));
}

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
          initialRoute: routes.Routes.datesAroundView,
          onGenerateRoute: routes.Router().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey),
    );
  }
}
