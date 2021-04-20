import 'package:date_night/api/rest/rest_api_handler_data.dart';
import 'package:date_night/config/globals.dart';
import 'package:date_night/enums/development_mode.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiService {
  /// Base API Url
  static const envApiUrl = String.fromEnvironment('API_URL');
  String get apiUrl => envApiUrl.isNotEmpty ? envApiUrl : Globals.API_URL[DevelopmentModes.Test];

  /// Fetch other current dates
  Future<Map<String, dynamic>> getDatesAround(String token, [String lastId]) async {
    String url = '${apiUrl}dates_around';
    if (lastId != null) {
      url = '$url/?lastId=$lastId';
    }
    final response = await RestApiHandlerData.getData(url, {'Authorization': 'Bearer $token'});
    return response;
  }

  /// Get a random date idea
  Future<Map<String, dynamic>> getRandomDate(String token) async {
    final response = await RestApiHandlerData.getData('${apiUrl}random', {'Authorization': 'Bearer $token'});
    return response;
  }

  /// Get the winning date idea
  Future<Map<String, dynamic>> postDate(String token, Map<String, dynamic> body) async {
    print(body);
    final response = await RestApiHandlerData.postData('${apiUrl}date', body, {'Authorization': 'Bearer $token'});
    print(response);
    return response;
  }

  Future<Map<String, dynamic>> getARoom(String token) async {
    final respone = await RestApiHandlerData.getData('${apiUrl}get_a_room', {'Authorization': 'Bearer $token'});
    return respone;
  }

  Future<Map<String, dynamic>> deleteARoom(String token, String roomId) async {
    final respone =
        await RestApiHandlerData.deleteData('${apiUrl}get_a_room/?roomId=$roomId', {'Authorization': 'Bearer $token'});
    return respone;
  }
}
