import 'package:date_night/app/locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: Colors.white,
    textColor: Colors.black54,
    borderRadius: 25.0,
    borderWidth: 0,
    mainButtonTextColor: Colors.black54,
    margin: EdgeInsets.only(bottom: 60)
  ));
}