import './api_constants.dart';
import './rest/rest_api_handler_data.dart';

/// For querying a production API.
class ApiSdk {
  /// Fetch other current dates
  static Future<List<Map<String, Object>>> getDatesAround() async {
    final response =
        await RestApiHandlerData.getData('${apiConstants["dateNight"]}/');
    return response;
  }

  /// Get the winning date idea
  static Future postDate(dynamic body) async {
    final response = await RestApiHandlerData.postData(
        '${apiConstants["dateNight"]}/', body);
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
}
