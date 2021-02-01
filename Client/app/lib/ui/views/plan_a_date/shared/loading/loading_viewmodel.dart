import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/services/plan_a_date_single_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoadingViewModel extends FutureViewModel<void> {
  final NavigationService _navigationService = locator<NavigationService>();
  final PlanADateSingleService _planADateService =
      locator<PlanADateSingleService>();

  @override
  Future futureToRun() => getResults();

  Future<void> getResults() async {
    await _planADateService.calculateResults();
    await _navigationService.replaceWith(Routes.resultsView);
  }
}
