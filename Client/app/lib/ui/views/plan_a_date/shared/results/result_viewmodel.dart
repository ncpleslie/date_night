import 'package:stacked/stacked.dart';

class ResultsViewModel extends BaseViewModel {
    final NavigationService _navigationService = locator<NavigationService>();
  final PlanADateSingleService _planADateService =
      locator<PlanADateSingleService>();
}