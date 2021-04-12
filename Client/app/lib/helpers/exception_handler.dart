import 'package:date_night/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';

/// Helper class to handle exceptions 
/// by wrapping code in try/catch statements.
class ExceptionHandler {

  /// Runs a method inside a Try Catch to stop any exceptions 
  /// from bubbling and crashing the application.
  static Future<void> runInErrorHandlerAsync (
      Function codeToRun, String toastErrorTitle, String toastErrorMessage) async {
    try {
      await codeToRun();
    } catch (ex) {
      final DialogService _dialogService = locator<DialogService>();

      _dialogService.showDialog(
          title: toastErrorTitle, description: toastErrorMessage);
    }
  }
}
