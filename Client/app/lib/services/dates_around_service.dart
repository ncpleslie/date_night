import 'package:date_night/app/locator.dart';
import 'package:date_night/models/date_around_model.dart';
import 'package:date_night/models/report_model.dart';
import 'package:date_night/models/server_error_model.dart';
import 'package:date_night/services/api_service.dart';
import 'package:date_night/services/user_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class DatesAroundService {
  final UserService _userService = locator<UserService>();
  final ApiService _apiService = locator<ApiService>();
  final SnackbarService _snackBar = locator<SnackbarService>();

  Future reportDate(String id) async {
    await _apiService.reportADate(_userService.userToken, ReportModel(dateAroundId: id));
    _snackBar.showSnackbar(
      title: "Thank you",
      message: "This date has been reported",
    );
  }

  Future<List<DateAroundModel>> getDates({String previousDateId = ""}) async {
    print('Querying external source 2');

    final String idToken = _userService.userToken;
    final Map<String, dynamic> response = previousDateId.isNotEmpty
        ? await _apiService.getDatesAround(idToken, previousDateId)
        : await _apiService.getDatesAround(idToken);

    try {
      final List<Map<String, dynamic>> datesAround = response["datesAround"].cast<Map<String, dynamic>>();
      return datesAround.map((Map<String, dynamic> dateAround) => DateAroundModel.fromServerMap(dateAround)).toList();
    } on NoSuchMethodError {
      // It's probably a cast error because we recieved a server error. The server should've returned a user-friendly error message
      _snackBar.showSnackbar(title: "Yikes", message: ServerErrorModel.fromServerMap(response).error);
    } catch (e) {
      _snackBar.showSnackbar(title: "Yikes", message: "An unknown error occurred.");
    }

    return List.empty();
  }
}
