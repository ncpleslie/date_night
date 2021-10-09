import 'dart:math';

import 'package:date_night/app/locator.dart';
import 'package:date_night/models/date_request_model.dart';
import 'package:date_night/models/date_response_model.dart';
import 'package:date_night/services/api_service.dart';
import 'package:date_night/services/plan_a_date_base_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PlanADateSingleService {
  final PlanADateBaseService _planADateBaseService = locator<PlanADateBaseService>();
  final ApiService _apiService = locator<ApiService>();

  /// List of all the current date ideas.
  List<List<String>> dateIdeas = <List<String>>[<String>[], <String>[]];

  /// For Final Selection
  DateResponse? dateResponse;

  /// The current date editor.
  int currentEditor = 0;

  /// Set who the current editor is.
  void setCurrentEditor(int editor) {
    _planADateBaseService.isMultiEditing = false;
    currentEditor = editor;
  }

  /// Returns the list of date ideas of the current editor
  List<String> getCurrentEditorsIdeasList() {
    return dateIdeas[currentEditor];
  }

  /// Determines is the current editors list is valid.
  bool isCurrentEditorsListValid() {
    return dateIdeas[currentEditor].isNotEmpty;
  }

  /// Determines is the selected editor has a valid list.
  bool isSelectedEditorsListValid(int index) {
    return dateIdeas[index].isNotEmpty;
  }

  /// Determine if all lists are valid.
  bool isAllEditorsListsValid() {
    for (int i = 0; i <= dateIdeas.length - 1; i++) {
      final bool validList = isSelectedEditorsListValid(i);
      if (!validList) {
        return validList;
      }
    }
    return true;
  }

  /// Determines if any list is valid.
  bool isAnyEditorsListValid() {
    for (int i = 0; i <= dateIdeas.length - 1; i++) {
      final bool validList = isSelectedEditorsListValid(i);
      if (validList) {
        return validList;
      }
    }
    return false;
  }

  /// Removes the current editors idea by index.
  void removeItemAt(int index) {
    dateIdeas[currentEditor].removeAt(index);
  }

  /// Add a single idea to the current editors idea list.
  void addIdea(String idea) {
    final String ideaNormalised = idea.replaceFirst(RegExp(r'^\s+'), '');
    dateIdeas[currentEditor].add(ideaNormalised);
  }

  /// Add allideas to the current editing user.
  void addIdeas(List<String> ideas) {
    dateIdeas[currentEditor].addAll(ideas);
  }

  /// Determine the final result.
  Future<void> calculateResults() async {
    print('Querying external source 10');

    // Determine result
    // Combine lists
    // If value in there twice, that is the answer
    // Else return random answer
    // Clear lists
    List<String> flatList = dateIdeas.expand((i) => i).toList();
    var dateReq = DateRequest(dateIdeas: flatList);
    try {
      final Map<String, dynamic> response = await _apiService.postDate(dateReq);
      final DateResponse date = DateResponse.fromServerMap(response);
      dateResponse = date;
    } catch (_) {
      dateResponse = DateResponse(chosenIdea: dateReq.dateIdeas[Random().nextInt(dateReq.dateIdeas.length)]);
    }
    clearAllSingleLists();
  }

  /// Deletes all dates from all lists.
  void clearAllSingleLists() {
    for (List<String> ideas in dateIdeas) {
      ideas.clear();
    }
  }
}
