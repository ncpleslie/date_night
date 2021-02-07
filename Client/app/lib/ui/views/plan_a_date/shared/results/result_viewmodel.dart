import 'package:date_night/app/locator.dart';
import 'package:date_night/services/plan_a_date_single_service.dart';
import 'package:date_night/services/result_feedback_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ResultsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PlanADateSingleService _planADateService =
      locator<PlanADateSingleService>();
  final ResultFeedbackService _resultFeedbackService =
      locator<ResultFeedbackService>();

  String getChosenIdea() {
    return _planADateService.dateResponse.chosenIdea;
  }

  String getRandomFeedback() {
    return _resultFeedbackService.getRandomFeedback();
  }

  void removeView() {
    _navigationService.back();
  }
}
