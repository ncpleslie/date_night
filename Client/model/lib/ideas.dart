import 'dart:math';

import 'package:api/main.dart';
import 'package:model/models/date_request_model.dart';
import 'package:model/models/date_response_model.dart';
import 'package:model/models/random_date_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'constants/date_ideas.dart';

mixin IdeasModel on Model {
  /// List of all the current date ideas.
  List<List<String>> dateIdeas = <List<String>>[<String>[], <String>[]];

  // For Final Selection
  String chosenIdea;

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
    final Map<String, dynamic> dateReq =
        DateRequest(dateIdeas: dateIdeas).toJson();
    try {
      final Map<String, dynamic> response = await ApiSdk.postDate(dateReq);
      final DateResponse date = DateResponse.fromServerMap(response);
      chosenIdea = date.chosenIdea;
    } catch (_) {
      await Future<void>.delayed(const Duration(seconds: 2), () {
        chosenIdea =
            dateReq['dateIdeas'][Random().nextInt(dateReq['dateIdeas'].length)];
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

  /// Get a random date idea.
  Future<String> randomIdea() async {
    final Map<String, dynamic> response = await ApiSdk.getRandomDate();
    final RandomDate randomDate = RandomDate.fromServerMap(response);
    return randomDate.date;
  }

  // List<String> chosenDateIdeas = <String>[];
  // List<String> personOneIdeas = <String>[];
  // List<String> personTwoIdeas = <String>[];

  // // Knowing who is editing
  // bool isPersonOneEditing = false;
  // bool isPersonTwoEditing = false;

  // void addPersonOneIdeas(List<String> personOneIdea) {
  //   personOneIdeas.addAll(personOneIdea);
  // }

  // void addPersonTwoIdeas(List<String> personTwoIdea) {
  //   personTwoIdeas.addAll(personTwoIdea);
  // }

  // void combineLists() {
  //   chosenDateIdeas = List<String>.from(personOneIdeas)..addAll(personTwoIdeas);
  //   chosenDateIdeas.shuffle();
  // }

  // // From Fetching ideas
  // List<DateAroundModel> dateIdeasList = <DateAroundModel>[];

  // List<DateAroundModel> get displayedIdeas {
  //   return List<DateAroundModel>.from(dateIdeasList);
  // }

  // // For adding ideas
  // final List<String> listOfDateStrings = <String>[];

  // void dateIdeaEntries(String string) {
  //   listOfDateStrings.add(string);
  // }

  // String compareAllIdeas() {
  //   // If person one and person two enter same idea
  //   // return similar idea
  //   // else
  //   // return a random idea
  //   //compare shortest list against longest list

  //   if (personOneIdeas.length >= personTwoIdeas.length) {
  //     for (int i = 0; i <= personOneIdeas.length - 1; i++) {
  //       for (int j = 0; j <= personTwoIdeas.length - 1; j++) {
  //         if (personOneIdeas[i].toLowerCase() ==
  //             personTwoIdeas[j].toLowerCase()) {
  //           chosenIdea = personOneIdeas[i];
  //         }
  //       }
  //     }
  //   } else {
  //     for (int i = 0; i <= personTwoIdeas.length - 1; i++) {
  //       for (int j = 0; j <= personOneIdeas.length - 1; j++) {
  //         if (personTwoIdeas[i].toLowerCase() ==
  //             personOneIdeas[j].toLowerCase()) {
  //           chosenIdea = personTwoIdeas[i];
  //         }
  //       }
  //     }
  //   }

  //   combineLists();
  //   final Random random = Random();

  //   chosenIdea ??= chosenIdea =
  //       chosenDateIdeas[random.nextInt(chosenDateIdeas.length)].toString();

  //   // Remove Dupes
  //   // Called twice because it could be in there twice

  //   if (chosenDateIdeas.contains(chosenIdea)) {
  //     chosenDateIdeas.remove(chosenIdea);
  //     if (chosenDateIdeas.contains(chosenIdea)) {
  //       chosenDateIdeas.remove(chosenIdea);
  //     }
  //   }

  //   //Once all done
  //   // Upload data
  //   uploadDateIdeas();

  //   return chosenIdea;
  // }

  // // Loading Indicators
  // bool _isLoading = false;

  // bool get isLoading {
  //   return _isLoading;
  // }

  // // Error Handling
  // bool _errorHandling() {
  //   _isLoading = false;
  //   notifyListeners();
  //   return false;
  // }

  // Future<void> uploadDateIdeas() async {
  //   final Random random = Random();
  //   final List<String> _emojiList = <String>['🎉', '😍', '🍾', '🍻'];

  //   final Map<String, dynamic> dateIdeas = <String, dynamic>{
  //     'chosenDate': chosenIdea,
  //     'otherIdeas': chosenDateIdeas,
  //     'randomEmoji': _emojiList[random.nextInt(_emojiList.length)],
  //     'uploadTime': DateTime.now()
  //   };

  //   FirebaseFirestore.instance.runTransaction(
  //     (Transaction transaction) async {
  //       final CollectionReference collectionRef =
  //           FirebaseFirestore.instance.collection('date_ideas');
  //       await collectionRef.doc().set(dateIdeas);
  //     },
  //   );
  // }

  // void clearLastVisible() {
  //   _lastVisible = null;
  // }

  // DocumentSnapshot _lastVisible;
  // List<DateAroundModel> fetchedDateIdeas = <DateAroundModel>[];

  // Future<List<DocumentSnapshot>> fetchDateIdeas() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   QuerySnapshot snapshot;
  //   DateAroundModel dateIdeas;

  //   if (_lastVisible == null) {
  //     snapshot = await FirebaseFirestore.instance
  //         .collection('date_ideas')
  //         .orderBy('uploadTime', descending: true)
  //         .limit(10)
  //         .get();
  //   } else {
  //     snapshot = await FirebaseFirestore.instance
  //         .collection('date_ideas')
  //         .orderBy('uploadTime', descending: true)
  //         .startAfter(<Timestamp>[_lastVisible['uploadTime']])
  //         .limit(10)
  //         .get();
  //   }

  //   if (snapshot != null && snapshot.docs.isNotEmpty) {
  //     _lastVisible = snapshot.docs[snapshot.docs.length - 1];

  //     for (DocumentSnapshot dateData in snapshot.docs) {
  //       dateIdeas = DateAroundModel(
  //           chosenDate: dateData['chosenDate'],
  //           otherIdeas: dateData['otherIdeas'],
  //           randomEmoji: dateData['randomEmoji']);
  //       fetchedDateIdeas.add(dateIdeas);
  //     }
  //     dateIdeasList = fetchedDateIdeas;
  //   }

  //   if (snapshot.docs.isEmpty) {
  //     _errorHandling();
  //   }
  //   _isLoading = false;
  //   notifyListeners();
  //   return snapshot.docs;
  // }
}
