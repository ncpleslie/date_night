import 'dart:async';

import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/models/date_around_model.dart';
import 'package:date_night/services/dates_around_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DatesAroundViewModel extends FutureViewModel<List<DateAroundModel>> {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatesAroundService _datesAroundService = locator<DatesAroundService>();

  List<DateAroundModel> _dates = [];
  List<DateAroundModel> get dates => _dates;

  bool _isLoading = false;

  Future<List<DateAroundModel>> loadMore({bool clearCacheData = false}) async {
    if (_isLoading) {
      return _dates;
    }

    if (clearCacheData) {
      _dates = [];
    }

    _isLoading = true;

    List<DateAroundModel> newDates =
        await _datesAroundService.getDates(previousDateId: _dates.isNotEmpty ? _dates[_dates.length - 1].id : "");
    _dates.addAll(newDates);
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
