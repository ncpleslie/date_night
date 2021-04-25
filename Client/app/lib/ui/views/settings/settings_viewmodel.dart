import 'dart:async';

import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/config/about.dart';
import 'package:date_night/config/globals.dart';
import 'package:date_night/enums/dialog_type.dart';
import 'package:date_night/services/user_service.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends FutureViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final UserService _userService = locator<UserService>();
  final DialogService _dialogService = locator<DialogService>();

  AboutModel _about;
  AboutModel get about => _about;

  bool _isLightMode = true;
  bool get isLightMode => _isLightMode;

  bool _isPublic;
  bool get isPublic => _isPublic;

  Future<void> setIsPublic(bool value) async {
    await _userService.setPublic(value);
    _isPublic = await _userService.getPublic();
    notifyListeners();
  }

  void deleteDeviceData() async {
    await _userService.signOutAndDelete();
    _snackbarService.showSnackbar(title: 'Data Deleted', message: 'The app will now restart');
    Timer(Duration(seconds: 3), () async => await _navigationService.clearStackAndShow(Routes.bootView));
  }

  void toggleLightMode() {
    _isLightMode = !_isLightMode;
    notifyListeners();
  }

  @override
  Future futureToRun() => _getAppInfo();

  Future<void> _getAppInfo() async {
    _isPublic = await _userService.getPublic();
    _about = await About.packageInfo();
    notifyListeners();
  }

  void showTermsAndConditions() async {
    await _showPolicyDialog('Terms and Conditions', Globals.TERMS_AND_CONDITIONS);
  }

  void showPrivacyPolicy() async {
    await _showPolicyDialog('Privacy Policy', Globals.PRIVACY_POLICY);
  }

  Future<void> _showPolicyDialog(String title, String fileLocation) async {
    try {
      var policyWording = await rootBundle.loadString(fileLocation);
      await _dialogService.showCustomDialog(
          title: title, barrierDismissible: true, variant: DialogType.LongText, description: policyWording);
    } catch (error) {
      print(error.toString());
      await _dialogService.showCustomDialog(
          title: 'Yikes',
          barrierDismissible: true,
          variant: DialogType.Basic,
          description: 'An unknown error occurred trying to retrieve: $title');
    }
  }
}
