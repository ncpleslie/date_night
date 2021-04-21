import 'package:date_night/api/rest/rest_api_handler_data.dart';
import 'package:date_night/config/globals.dart';
import 'package:date_night/enums/development_mode.dart';
import 'package:date_night/models/date_request_model.dart';
import 'package:date_night/models/report_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiService {
  /// Base API Url
  static const envApiUrl = String.fromEnvironment('API_URL');
  String get apiUrl => envApiUrl.isNotEmpty ? envApiUrl : Globals.API_URL[DevelopmentModes.Test];

  /// Fetch other current dates.
  /// GET
  Future<Map<String, dynamic>> getDatesAround(String token, [String lastId]) async {
    String url = '${apiUrl}dates_around';
    if (lastId != null) {
      url = '$url/?lastId=$lastId';
    }
    return await RestApiHandlerData.getData(url, {'Authorization': 'Bearer $token'});
  }

  /// Get a random date idea.
  /// GET
  Future<Map<String, dynamic>> getRandomDate(String token) async {
    return await RestApiHandlerData.getData('${apiUrl}random', {'Authorization': 'Bearer $token'});
  }

  /// Get the winning date idea.
  /// POST
  Future<Map<String, dynamic>> postDate(String token, DateRequest body) async {
    return await RestApiHandlerData.postData('${apiUrl}date', body.toJson(), {'Authorization': 'Bearer $token'});
  }

  /// GET
  Future<Map<String, dynamic>> getARoom(String token) async {
    return await RestApiHandlerData.getData('${apiUrl}get_a_room', {'Authorization': 'Bearer $token'});
  }

  /// DELETE
  Future<Map<String, dynamic>> deleteARoom(String token, String roomId) async {
    return await RestApiHandlerData.deleteData(
        '${apiUrl}get_a_room/?roomId=$roomId', {'Authorization': 'Bearer $token'});
  }

  /// POST
  Future reportADate(String token, ReportModel body) async {
    await RestApiHandlerData.postData('${apiUrl}report_a_date', body.toJson(), {'Authorization': 'Bearer $token'});
  }
}
