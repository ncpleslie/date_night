import 'package:date_night/app/locator.dart';
import 'package:date_night/services/dates_around_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DatesAroundCardViewModel extends BaseViewModel {
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final DatesAroundService _datesAroundService = locator<DatesAroundService>();

  bool _isReported = false;
  bool get isReported => _isReported;

  void reportDate(String id) {
    _datesAroundService.reportDate(id);
    _snackbarService.showSnackbar(
      title: "Thank you",
      message: "This date has been reported",
    );
    _isReported = true;
    notifyListeners();
  }
}
