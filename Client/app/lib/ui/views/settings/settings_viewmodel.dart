import 'dart:async';

import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/config/about.dart';
import 'package:date_night/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends FutureViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final UserService _userService = locator<UserService>();

  AboutModel _about;
  AboutModel get about => _about;

  bool _isLightMode = true;
  bool get isLightMode => _isLightMode;

  void deleteDeviceData() async {
    await _userService.signOutAndDelete();
    _snackbarService.showSnackbar(
        title: 'Data Deleted', message: 'The app will now restart');
    Timer(
        Duration(seconds: 3),
        () async =>
            await _navigationService.clearStackAndShow(Routes.bootView));
  }

  void toggleLightMode() {
    _isLightMode = !_isLightMode;
    notifyListeners();
  }

  @override
  Future futureToRun() => _getAppInfo();

  Future<void> _getAppInfo() async {
    _about = await About.packageInfo();
    notifyListeners();
  }
}
