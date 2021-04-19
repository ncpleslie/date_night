import 'package:api/main.dart';
import 'package:date_night/app/locator.dart';
import 'package:date_night/services/api_service.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_extended_dialog.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_extended_snackbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stacked_services/stacked_services.dart';

import 'globals.dart';

Future<void> setupApp() async {
  // Setup services
  setupLocator();

  // Config Environment
  final ApiService _apiService = locator<ApiService>();
  _apiService.apiUrl = String.fromEnvironment('API_URL') ?? Globals.API_URL[String.fromEnvironment('ENV', defaultValue: 'test')];

  // Setup custom UIs
  setupDialogUi();
  setupSnackbarUi();

  // Setup Firebase
  await Firebase.initializeApp();
}