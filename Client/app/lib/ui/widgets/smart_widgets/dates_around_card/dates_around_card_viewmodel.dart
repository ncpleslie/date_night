import 'package:date_night/app/locator.dart';
import 'package:date_night/services/dates_around_service.dart';
import 'package:stacked/stacked.dart';

class DatesAroundCardViewModel extends BaseViewModel {
  final DatesAroundService _datesAroundService = locator<DatesAroundService>();

  bool _isReported = false;
  bool get isReported => _isReported;

  void reportDate(String id) async {
    await _datesAroundService.reportDate(id);
    _isReported = true;
    notifyListeners();
  }
}
