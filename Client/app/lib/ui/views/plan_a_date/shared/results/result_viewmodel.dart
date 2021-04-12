import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/services/plan_a_date_base_service.dart';
import 'package:date_night/services/plan_a_date_multi_service.dart';
import 'package:date_night/services/plan_a_date_single_service.dart';
import 'package:date_night/services/result_feedback_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ResultsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PlanADateBaseService _planADateBaseService =
      locator<PlanADateBaseService>();
  final PlanADateSingleService _planADateSingleService =
      locator<PlanADateSingleService>();
  final PlanADateMultiService _planADateMultiService =
      locator<PlanADateMultiService>();
  final ResultFeedbackService _resultFeedbackService =
      locator<ResultFeedbackService>();

  String getChosenIdea() {
    if (_planADateBaseService.isMultiEditing) {
      return _planADateMultiService.dateMultiResponse?.chosenIdea;
    }
    return _planADateSingleService.dateResponse?.chosenIdea;
  }

  String getRandomFeedback() {
    return _resultFeedbackService.getRandomFeedback();
  }

  void removeView() {
    _planADateMultiService.clearAllMultiLists();
    _planADateSingleService.clearAllSingleLists();
    _navigationService.clearStackAndShow(Routes.homeView);
    
    notifyListeners();
  }
}
