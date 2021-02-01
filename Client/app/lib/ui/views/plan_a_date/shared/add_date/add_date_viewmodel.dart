import 'package:date_night/app/locator.dart';
import 'package:date_night/services/plan_a_date_single_service.dart';
import 'package:date_night/services/random_idea_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddDateViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PlanADateSingleService _planADateService =
      locator<PlanADateSingleService>();
  final RandomIdeaService _randomIdeaService = locator<RandomIdeaService>();

  final TextEditingController _textController = TextEditingController();
  TextEditingController get textController => _textController;

  bool _isMultiEditing = false;
  bool get isMultiEditing => _isMultiEditing;

  String _roomId = '';
  String get roomId => _roomId;

  Future<String> randomIdea() async {
    return await _randomIdeaService.randomIdea();
  }

  bool isListValid() {
    return _isMultiEditing
        ? throw Exception()
        : _planADateService.isCurrentEditorsListValid();
  }

  List<String> getEditorsList() {
    return _isMultiEditing
        ? throw Exception()
        : _planADateService.getCurrentEditorsIdeasList();
  }

  /// Moves the user back a screen, if they can
  void onFinish() {
    if (_isMultiEditing) {
      throw Exception();
    } else {
      if (_planADateService.isCurrentEditorsListValid()) {
        _navigationService.back();
      }
    }
  }

  /// Add the idea to list of possible dates
  Future<void> addIdea() async {
    // TODO: Implement Dialog Service Here
    if (_textController.text.isNotEmpty) {
      if (_isMultiEditing) {
        throw Exception();
      } else {
        _planADateService.addIdea(_textController.text);
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
    _isMultiEditing
        ? throw Exception() // model.removeMultiEditorsItemAt(index);
        : _planADateService.removeItemAt(index);
    notifyListeners();
  }
}
