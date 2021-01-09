import 'dart:math';
import 'package:api/main.dart';
import 'package:model/models/date_request_model.dart';
import 'package:model/models/date_response_model.dart';
import 'package:scoped_model/scoped_model.dart';

mixin IdeasModel on Model {
  /// List of all the current date ideas.
  // TODO: Refactor this so it is a single list
  List<List<String>> dateIdeas = <List<String>>[<String>[], <String>[]];

  /// For Final Selection
  DateResponse dateResponse;

  /// The current date editor.
  int currentEditor = 0;

  /// Set who the current editor is.
  void setCurrentEditor(int editor) {
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
    notifyListeners();
  }

  /// Add a single idea to the current editors idea list.
  void addIdea(String idea) {
    final String ideaNormalised = idea.replaceFirst(RegExp(r'^\s+'), '');
    dateIdeas[currentEditor].add(ideaNormalised);
    notifyListeners();
  }

  /// Add allideas to the current editing user.
  void addIdeas(List<String> ideas) {
    dateIdeas[currentEditor].addAll(ideas);
  }

  /// Determine the final result.
  Future<void> calculateResults() async {
    // Determine result
    // Combine lists
    // If value in there twice, that is the answer
    // Else return random answer
    // Clear lists
    List<String> flatList = dateIdeas.expand((i) => i).toList();
    final Map<String, dynamic> dateReq =
        DateRequest(dateIdeas: flatList).toJson();
    try {
      final Map<String, dynamic> response = await ApiSdk.postDate(dateReq);
      final DateResponse date = DateResponse.fromServerMap(response);
      dateResponse = date;
    } catch (_) {
      await Future<void>.delayed(const Duration(seconds: 2), () {
        dateResponse = DateResponse(
            chosenIdea: dateReq['dateIdeas']
                [Random().nextInt(dateReq['dateIdeas'].length)]);
      });
    }
    clearAllLists();
  }

  /// Deletes all dates from all lists.
  void clearAllLists() {
    for (List<String> ideas in dateIdeas) {
      ideas.clear();
    }
    notifyListeners();
  }
}
