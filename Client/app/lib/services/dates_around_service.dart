import 'package:date_night/app/locator.dart';
import 'package:date_night/models/date_around_model.dart';
import 'package:date_night/services/api_service.dart';
import 'package:date_night/services/user_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DatesAroundService {
  final UserService _userService = locator<UserService>();
  final ApiService _apiService = locator<ApiService>();

  void reportDate(String id) {
    print('Reported: $id');
  }

  Future<List<DateAroundModel>> getDates({String previousDateId = ""}) async {
    print('Querying external source 2');

    final String idToken = _userService.userToken;
    final Map<String, dynamic> response = previousDateId.isNotEmpty
        ? await _apiService.getDatesAround(idToken, previousDateId)
        : await _apiService.getDatesAround(idToken);

    final List<Map<String, dynamic>> datesAround = response["datesAround"].cast<Map<String, dynamic>>();

    List<DateAroundModel> newDates =
        datesAround.map((Map<String, dynamic> dateAround) => DateAroundModel.fromServerMap(dateAround)).toList();

    return newDates;
  }
}
