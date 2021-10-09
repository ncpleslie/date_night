import 'package:date_night/api/rest/rest_api_handler_data.dart';
import 'package:date_night/app/locator.dart';
import 'package:date_night/config/globals.dart';
import 'package:date_night/enums/development_mode.dart';
import 'package:date_night/models/date_request_model.dart';
import 'package:date_night/models/report_model.dart';
import 'package:date_night/services/user_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiService {
  final UserService _userService = locator<UserService>();

  /// Base API Url
  String? apiUrl;

  ApiService() {
    apiUrl = Globals.API_URL;

    if (apiUrl == null) {
      apiUrl = Globals.API_URLS[Globals.DEVELOPMENT_MODE];
    } else {
      apiUrl = Globals.API_URLS[DevelopmentModes.Test];
    }

    print('API service initialised with API URL: $apiUrl');
  }

  /// Fetch other current dates.
  /// GET
  Future<Map<String, dynamic>> getDatesAround([String? lastId]) async {
    var token = await _userService.userToken;
    String url = '${apiUrl}dates_around';
    if (lastId != null) {
      url = '$url/?lastId=$lastId';
    }
    return await RestApiHandlerData.getData(url, {'Authorization': 'Bearer $token'});
  }

  /// Get a random date idea.
  /// GET
  Future<Map<String, dynamic>> getRandomDate() async {
    var token = await _userService.userToken;
    return await RestApiHandlerData.getData('${apiUrl}random', {'Authorization': 'Bearer $token'});
  }

  /// Get the winning date idea.
  /// POST
  Future<Map<String, dynamic>> postDate(DateRequest body) async {
    body.isPublic = await _userService.getPublic();
    var token = await _userService.userToken;
    return await RestApiHandlerData.postData('${apiUrl}date', body.toJson(), {'Authorization': 'Bearer $token'});
  }

  /// GET
  Future<Map<String, dynamic>> getARoom() async {
    var token = await _userService.userToken;
    return await RestApiHandlerData.getData('${apiUrl}get_a_room', {'Authorization': 'Bearer $token'});
  }

  /// DELETE
  Future<Map<String, dynamic>> deleteARoom(String roomId) async {
    var token = await _userService.userToken;
    return await RestApiHandlerData.deleteData(
        '${apiUrl}get_a_room/?roomId=$roomId', {'Authorization': 'Bearer $token'});
  }

  /// POST
  Future reportADate(ReportModel body) async {
    var token = await _userService.userToken;
    await RestApiHandlerData.postData('${apiUrl}report_a_date', body.toJson(), {'Authorization': 'Bearer $token'});
  }
}
