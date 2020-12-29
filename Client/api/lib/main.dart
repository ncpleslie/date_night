import './api_constants.dart';
import './rest/rest_api_handler_data.dart';

/// For querying a production API.
class ApiSdk {
  /// Fetch other current dates
  static Future<List<Map<String, Object>>> getDatesAround() async {
    final response = await RestApiHandlerData.getData(
        '${apiConstants["dateNight"]}/dates_around');
    return response;
  }

  static Future<List<Map<String, Object>>> getRandomDate() async {
    final response =
        await RestApiHandlerData.getData('${apiConstants["dateNight"]}/random');
    return response;
  }

  /// Get the winning date idea
  static Future postDate(List<List<String>> body) async {
    final response = await RestApiHandlerData.postData(
        '${apiConstants["dateNight"]}/date', body);
    return response;
  }
}

/// A mock API for on device testing.
class MockApiSdk {
  static Future<List<Map<String, Object>>> getDatesAround() {
    print('Getting example dates from Mock API service.');
    print('This service should only be used for development.');
    const int length = 2;
    return Future<List<Map<String, Object>>>.delayed(
      const Duration(seconds: 1),
      () => List<Map<String, Object>>.generate(
        length,
        (int index) => <String, Object>{
          'chosenDate': 'Null',
          'otherIdeas': <Object>['Null', 'Null'],
          'datePosted': DateTime.now()
        },
      ),
    );
  }

  static Future<Map<String, String>> postDate(List<List<String>> body) async {
    print('Calculating results');
    return await Future<Map<String, String>>.delayed(
        const Duration(seconds: 3), () => {'chosenIdea': 'Null'});
  }

  static Future<Map<String, String>> getRandomDate() async {
    print('Getting Random Date');
    return await Future<Map<String, String>>.delayed(
        const Duration(seconds: 3), () => {'date': 'Unknown'});
  }
}
