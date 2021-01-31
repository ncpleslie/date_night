import 'dart:async';

import 'package:api/main.dart';
import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/models/date_around_model.dart';
import 'package:date_night/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DatesAroundViewModel extends FutureViewModel<List<DateAroundModel>> {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();


  List<DateAroundModel> _dates = List<DateAroundModel>();
  List<DateAroundModel> get dates => _dates;

  bool _isLoading = false;

  Future<List<DateAroundModel>> loadMore({bool clearCacheData = false}) async {
    print('Querying external source 2');
    if (_isLoading) {
      return _dates;
    }

    if (clearCacheData) {
      _dates = List<DateAroundModel>();
      notifyListeners();
    }

    _isLoading = true;
    try {
      final String idToken = _userService.userToken;
      final Map<String, dynamic> response = _dates.isNotEmpty
          ? await ApiSdk.getDatesAround(idToken, _dates[_dates.length - 1].id)
          : await ApiSdk.getDatesAround(idToken);

      final List<Map<String, dynamic>> datesAround =
          response["datesAround"].cast<Map<String, dynamic>>();

      List<DateAroundModel> newDates = datesAround
          .map((Map<String, dynamic> dateAround) =>
              DateAroundModel.fromServerMap(dateAround))
          .toList();

      _dates.addAll(newDates);
    } catch (e) {
      _isLoading = false;
      throw e;
    }

    _isLoading = false;
    notifyListeners();
    return _dates;
  }

  Future navigateToSettings() async {
    await _navigationService.navigateTo(Routes.settingsView);
  }

  @override
  Future<List<DateAroundModel>> futureToRun() => loadMore();
}
