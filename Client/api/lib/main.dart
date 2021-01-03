import './api_constants.dart';
import './rest/rest_api_handler_data.dart';

/// For querying a production API.
class ApiSdk {
  /// Fetch other current dates
  static Future<Map<String, dynamic>> getDatesAround([String lastId]) async {
    String url = '${apiConstants["dateNight"]}/dates_around';
    if (lastId != null) {
      url = '$url/?lastId=$lastId';
    }
    final response = await RestApiHandlerData.getData(url);
    return response;
  }

  static Future<Map<String, dynamic>> getRandomDate() async {
    final response =
        await RestApiHandlerData.getData('${apiConstants["dateNight"]}/random');
    return response;
  }

  /// Get the winning date idea
  static Future<Map<String, dynamic>> postDate(
      Map<String, dynamic> body) async {
    final response = await RestApiHandlerData.postData(
        '${apiConstants["dateNight"]}/date', body);
    return response;
  }
}

/// A mock API for on device testing.
class MockApiSdk {
  static Future<Map<String, dynamic>> getDatesAround() {
    print('Getting example dates from Mock API service.');
    print('This service should only be used for development.');
    const int length = 2;
    return Future<Map<String, Object>>.delayed(
      const Duration(seconds: 1),
      () => {
        "datesAround": List<Map<String, Object>>.generate(
          length,
          (int index) => <String, Object>{
            'chosenIdea': 'Null',
            'otherIdeas': <Object>['Null', 'Null'],
            'date': DateTime.now(),
            'id': '123'
          },
        )
      },
    );
  }

  static Future<Map<String, dynamic>> postDate(List<List<String>> body) async {
    print('Calculating mock results');
    return await Future<Map<String, String>>.delayed(
        const Duration(seconds: 3), () => {'chosenIdea': 'Null'});
  }

  static Future<Map<String, dynamic>> getRandomDate() async {
    print('Getting Random Mock Date');
    return await Future<Map<String, String>>.delayed(
        const Duration(seconds: 3), () => {'date': 'Unknown'});
  }
}
