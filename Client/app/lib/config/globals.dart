import 'package:date_night/enums/development_mode.dart';

class Globals {
  static const String API_URL = String.fromEnvironment('API_URL');
  static const _devMode = String.fromEnvironment('ENV');
  // ignore: non_constant_identifier_names
  static DevelopmentModes DEVELOPMENT_MODE = DevelopmentModes.values.firstWhere(
      (mode) => mode.toString().toLowerCase() == 'DevelopmentModes.$_devMode'.toLowerCase());
  static const String APP_NAME = 'Date Night';
  static const String TERMS_AND_CONDITIONS = 'assets/documents/terms_and_conditions.md';
  static const String PRIVACY_POLICY = 'assets/documents/privacy_policy.md';
  static const Map<DevelopmentModes, String> API_URLS = {
    DevelopmentModes.Test: "https://us-central1-date-night-api.cloudfunctions.net/",
    DevelopmentModes.Emulator: "http://10.0.2.2:5003/date-night-api/us-central1/"
  };
  static const int DEFAULT_TIMEOUT_IN_SECS = 5;
  static const int MAX_API_RETRIES = 3;

  static const String MAIN_PAGE_TITLE = "Dates Around";
  static const String SINGLE_PLAN_A_DATE_PAGE_TITLE = "Plan a date";
  static const String MULTI_PLAN_A_DATE_PAGE_TITLE = "Plan a date";
}
