import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/services/plan_a_date_base_service.dart';
import 'package:date_night/services/plan_a_date_multi_service.dart';
import 'package:date_night/services/plan_a_date_single_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoadingViewModel extends FutureViewModel<void> {
  final NavigationService _navigationService = locator<NavigationService>();
  final PlanADateBaseService _planADateBaseService =
      locator<PlanADateBaseService>();
  final PlanADateSingleService _planADateSingleService =
      locator<PlanADateSingleService>();
  final PlanADateMultiService _planADateMultiService =
      locator<PlanADateMultiService>();

  @override
  Future futureToRun() => getResults();

  Future<void> getResults() async {
    if (_planADateBaseService.isMultiEditing) {
      await _planADateMultiService.calculateResults();
    } else {
      await _planADateSingleService.calculateResults();
    }
    await _navigationService.replaceWith(Routes.resultsView);
  }
}
