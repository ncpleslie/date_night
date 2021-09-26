import 'package:date_night/app/locator.dart';
import 'package:date_night/config/globals.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_extended_dialog.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_extended_snackbar.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> setupApp() async {
  print("Application starting...");

  
  // Setup services
  setupLocator();

  // Setup custom UIs
  setupDialogUi();
  setupSnackbarUi();

  // Setup Firebase
  await Firebase.initializeApp();

  print('Application initialised in ${Globals.DEVELOPMENT_MODE}');
}