import 'package:date_night/enums/development_mode.dart';

class Globals {
  static const String TERMS_AND_CONDITIONS = 'assets/documents/terms_and_conditions.md';
  static const String PRIVACY_POLICY = 'assets/documents/privacy_policy.md';
  static const Map<DevelopmentModes, String> API_URL = {
    DevelopmentModes.Test: "https://us-central1-date-night-api.cloudfunctions.net/",
    DevelopmentModes.Emulator: "http://10.0.2.2:5003/date-night-api/us-central1/"
  };
}
