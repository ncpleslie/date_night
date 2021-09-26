import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:date_night/config/globals.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

import 'api_exception.dart';

class ApiBaseHelper {
  Future<dynamic> get(String url, [Map<String, String> headers]) async {
    var responseJson;
    try {
      final response = await httpRetry(
          http.get(Uri.parse(url), headers: headers).timeout(Duration(seconds: Globals.DEFAULT_TIMEOUT_IN_SECS)));
          
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body, [Map<String, String> headers]) async {
    try {
      final response = await httpRetry(http
          .post(Uri.parse(url),
              headers: {'Content-type': 'application/json', 'Accept': 'application/json', ...headers},
              body: json.encode(body))
          .timeout(Duration(seconds: Globals.DEFAULT_TIMEOUT_IN_SECS)));

      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> put(String url, dynamic body) async {
    var responseJson;
    try {
      final response = await httpRetry(
          http.put(Uri.parse(url), body: body).timeout(Duration(seconds: Globals.DEFAULT_TIMEOUT_IN_SECS)));

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> delete(String url, [Map<String, String> headers]) async {
    var apiResponse;
    try {
      final response = await httpRetry(
          http.delete(Uri.parse(url), headers: headers).timeout(Duration(seconds: Globals.DEFAULT_TIMEOUT_IN_SECS)));
          
      apiResponse = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return apiResponse;
  }
}

Future<dynamic> httpRetry(Future<dynamic> call) async {
  return await retry(() => call,
      maxAttempts: Globals.MAX_API_RETRIES, retryIf: (e) => e is SocketException || e is TimeoutException);
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      if (response.body.isEmpty) {
        return;
      }
      return json.decode(response?.body?.toString());
    case 400:
      return json.decode(response.body.toString());
    case 401:
    case 403:
      return json.decode(response.body.toString());
    case 429:
      return json.decode(response.body.toString());
    case 500:
    default:
      return FetchDataException('Error occured while communicating with server. StatusCode: ${response.statusCode}');
  }
}
