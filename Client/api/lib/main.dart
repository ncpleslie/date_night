import './api_constants.dart';
import './rest/rest_api_handler_data.dart';

/// For querying a production API.
class ApiSdk {
  /// Fetch other current dates
  static Future<Map<String, dynamic>> getDatesAround(String token,
      [String lastId]) async {
    String url = '${apiUrl}dates_around';
    if (lastId != null) {
      url = '$url/?lastId=$lastId';
    }
    final response = await RestApiHandlerData.getData(
        url, {'Authorization': 'Bearer $token'});
    return response;
  }

  /// Get a random date idea
  static Future<Map<String, dynamic>> getRandomDate(String token) async {
    final response = await RestApiHandlerData.getData('${apiUrl}random', {'Authorization': 'Bearer $token'});
    return response;
  }

  /// Get the winning date idea
  static Future<Map<String, dynamic>> postDate(String token,
      Map<String, dynamic> body) async {
    final response = await RestApiHandlerData.postData('${apiUrl}date', body, {'Authorization': 'Bearer $token'});
    return response;
  }

  static Future<Map<String, dynamic>> getARoom(String token) async {
    final respone = await RestApiHandlerData.getData('${apiUrl}get_a_room', {'Authorization': 'Bearer $token'});
    return respone;
  }

  static Future<Map<String, dynamic>> deleteARoom(String token, String roomId) async {
    final respone = await RestApiHandlerData.deleteData('${apiUrl}get_a_room/?roomId=$roomId', {'Authorization': 'Bearer $token'});
    return respone;
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
