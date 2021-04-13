import 'package:date_night/app/locator.dart';
import 'package:date_night/config/theme_data.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_extended_dialog.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_extended_snackbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/router.gr.dart' as routes;

void main() async {
  setupLocator();
  setupDialogUi();
  setupSnackbarUi();
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
    return MaterialApp(
        title: 'Date Night',
        theme: ThemeConfig.theme,
        initialRoute: routes.Routes.bootView,
        onGenerateRoute: routes.Router().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey);
  }
}
