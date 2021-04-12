import 'dart:async';

import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BootViewModel extends FutureViewModel<void> {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();

  @override
  Future<void> futureToRun() => signInAnon();

  Future<void> signInAnon() async {
    try {
      await _userService.signIn();
      await _navigationService.replaceWith(Routes.homeView);
    } catch (e) {
      throw e;
    }
  }
}
