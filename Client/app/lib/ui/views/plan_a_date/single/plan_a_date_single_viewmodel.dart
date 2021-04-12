import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/services/plan_a_date_single_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PlanADateSingleViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PlanADateSingleService _planADateService =
      locator<PlanADateSingleService>();

  bool isAnyEditorsListValid() {
    return _planADateService.isAnyEditorsListValid();
  }

  void clearAllLists() {
    _planADateService.clearAllSingleLists();
    notifyListeners();
  }

  bool isSelectedEditorsListValid(int editor) {
    return _planADateService.isSelectedEditorsListValid(editor);
  }

  /// Will navigate to the correct editing page based on is currently editing
  Future<void> navigateToEditScreen(int editor) async {
    _planADateService.setCurrentEditor(editor);
    await _navigationService.navigateTo(Routes.addDateView);
    notifyListeners();
  }

  /// Navigate to the next stage
  Future<void> navigateToLoading() async {
    if (_planADateService.isAnyEditorsListValid()) {
      await _navigationService.navigateTo(Routes.loadingView);
    }
  }
}
