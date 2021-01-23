import './api_helpers/api_base_helper.dart';

class RestApiHandlerData {
  static ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  static getData(String path, [Map<String, String> headers]) async {
    final response = await _apiBaseHelper.get('$path', headers);
    return response;
  }

  static postData(String path, dynamic body, [Map<String, String> headers]) async {
    final response = await _apiBaseHelper.post('$path', body, headers);
    return response;
  }
}
