bool devMode = false;
String get apiUrl => devMode ? apiConstants['dateNightEmulator'] : apiConstants['dateNight'];

Map<String, String> apiConstants = {
  "dateNight": "https://us-central1-date-night-api.cloudfunctions.net/",
  "dateNightEmulator": "http://10.0.2.2:5003/date-night-api/us-central1/"
};
