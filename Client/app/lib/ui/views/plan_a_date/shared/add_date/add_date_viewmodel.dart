import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/services/plan_a_date_base_service.dart';
import 'package:date_night/services/plan_a_date_multi_service.dart';
import 'package:date_night/services/plan_a_date_single_service.dart';
import 'package:date_night/services/random_idea_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddDateViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PlanADateSingleService _planADateSingleService =
      locator<PlanADateSingleService>();
    final PlanADateMultiService _planADateMultiService =
      locator<PlanADateMultiService>();
  final RandomIdeaService _randomIdeaService = locator<RandomIdeaService>();
  final PlanADateBaseService _planADateBaseService = locator<PlanADateBaseService>();

  final TextEditingController _textController = TextEditingController();
  TextEditingController get textController => _textController;

  bool isMultiEditing() {
    if (_planADateBaseService.isMultiEditing) {
      _roomId = _planADateMultiService.roomId;
      return true;
    }
    return false;
  }

  String _roomId = '';
  String get roomId => _roomId;

  Future<String> randomIdea() async {
    return await _randomIdeaService.randomIdea();
  }

  bool isListValid() {
    return isMultiEditing()
        ? _planADateMultiService.isMultiEditorsListValid()
        : _planADateSingleService.isCurrentEditorsListValid();
  }

  List<String> getEditorsList() {
    return isMultiEditing()
        ? _planADateMultiService.getMultiEditorsIdeasList()
        : _planADateSingleService.getCurrentEditorsIdeasList();
  }

  /// Moves the user back a screen, if they can or to the waiting screen
  void onFinish() {
    if (isMultiEditing()) {
      if (_planADateMultiService.isMultiEditorsListValid()) {
        _navigationService.replaceWith(Routes.waitingRoomView);
      }
    } else {
      if (_planADateSingleService.isCurrentEditorsListValid()) {
        _navigationService.back();
      }
    }
  }

  /// Add the idea to list of possible dates
  Future<void> addIdea() async {
    // TODO: Implement Dialog Service Here
    if (_textController.text.isNotEmpty) {
      if (isMultiEditing()) {
        _planADateMultiService.addMultiIdea(_textController.text);
      } else {
        _planADateSingleService.addIdea(_textController.text);
      }

      // Clear text from dialog.
      // Otherwise text will remain next time.
      _textController.clear();

      // Remove the dialog box.
      removeDialog();
      notifyListeners();
    }
  }

  /// Discard the date and remove the dialog box
  void removeDialog() async {
    _navigationService.back();
  }

  /// Removes the date idea from potential dates.
  void removeIdea(int index) {
    isMultiEditing()
        ? _planADateMultiService.removeMultiEditorsItemAt(index)
        : _planADateSingleService.removeItemAt(index);
    notifyListeners();
  }
}
