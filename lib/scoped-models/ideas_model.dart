import 'dart:math';

import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/date_ideas.dart';

class IdeasModel extends Model {
  List<String> chosenDateIdeas = [];
  List<String> personOneIdeas = [];
  List<String> personTwoIdeas = [];

  // Knowing who is editing
  bool isPersonOneEditing = false;
  bool isPersonTwoEditing = false;

  // For Final Selection
  String chosenIdea;

  void addPersonOneIdeas(List<String> personOneIdea) {
    personOneIdeas.addAll(personOneIdea);
  }

  void addPersonTwoIdeas(List<String> personTwoIdea) {
    personTwoIdeas.addAll(personTwoIdea);
  }

  void combineLists() {
    chosenDateIdeas = List<String>.from(personOneIdeas)..addAll(personTwoIdeas);
    chosenDateIdeas.shuffle();
  }

  void clearAllLists() {
    chosenIdea = null;
    chosenDateIdeas = <String>[];
    personOneIdeas = <String>[];
    personTwoIdeas = <String>[];
    notifyListeners();
  }

  // From Fetching ideas
  List<DateIdeas> dateIdeasList = [];

  List<DateIdeas> get displayedIdeas {
    return List<DateIdeas>.from(dateIdeasList);
  }

  // For adding ideas 
 final List<String> listOfDateStrings = [];

  void dateIdeaEntries(String string) {
    listOfDateStrings.add(string);
  }

  String compareAllIdeas() {
    // If person one and person two enter same idea
    // return similar idea
    // else
    // return a random idea
    //compare shortest list against longest list
    

    if (personOneIdeas.length >= personTwoIdeas.length) {
      for (int i = 0; i <= personOneIdeas.length - 1; i++) {
        for (int j = 0; j <= personTwoIdeas.length - 1; j++) {
          if (personOneIdeas[i].toLowerCase() ==
              personTwoIdeas[j].toLowerCase()) {
            chosenIdea = personOneIdeas[i];
          }
        }
      }
    } else {
      for (int i = 0; i <= personTwoIdeas.length - 1; i++) {
        for (int j = 0; j <= personOneIdeas.length - 1; j++) {
          if (personTwoIdeas[i].toLowerCase() ==
              personOneIdeas[j].toLowerCase()) {
            chosenIdea = personTwoIdeas[i];
          }
        }
      }
    }

    combineLists();
    final Random random = Random();

    if (chosenIdea == null) {
      chosenIdea =
          chosenDateIdeas[random.nextInt(chosenDateIdeas.length)].toString();
    }

    // Remove Dupes
    // Called twice because it could be in there twice

    if (chosenDateIdeas.contains(chosenIdea)) {
      chosenDateIdeas.remove(chosenIdea);
      if (chosenDateIdeas.contains(chosenIdea)) {
        chosenDateIdeas.remove(chosenIdea);
      }
    }

    //Once all done
    // Upload data
    uploadDateIdeas();

    return chosenIdea;
  }
  // Loading Indicators
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  // Error Handling
  bool _errorHandling() {
    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<Null> uploadDateIdeas() async {
    final random = Random();
    final List<String> _emojiList = ['🎉', '😍', '🍾', '🍻'];

    final Map<String, dynamic> dateIdeas = <String, dynamic>{
      'chosenDate': chosenIdea,
      'otherIdeas': chosenDateIdeas,
      'randomEmoji': _emojiList[random.nextInt(_emojiList.length)],
      'uploadTime': DateTime.now()
    };

    Firestore.instance.runTransaction(
      (Transaction transaction) async {
       final CollectionReference collectionRef =
            Firestore.instance.collection('date_ideas');
        await collectionRef.document().setData(dateIdeas);
      },
    );
  }

  void clearLastVisible() {
    _lastVisible = null;
  }

  DocumentSnapshot _lastVisible;
  List<DateIdeas>fetchedDateIdeas = <DateIdeas>[];

  Future<List<DocumentSnapshot>> fetchDateIdeas() async {
    _isLoading = true;

    QuerySnapshot snapshot;
    DateIdeas dateIdeas;

    if (_lastVisible == null) {
      snapshot = await Firestore.instance
          .collection('date_ideas')
          .orderBy('uploadTime', descending: true)
          .limit(10)
          .getDocuments();
    } else {
      snapshot = await Firestore.instance
          .collection('date_ideas')
          .orderBy('uploadTime', descending: true)
          .startAfter(<Timestamp>[_lastVisible['uploadTime']])
          .limit(10)
          .getDocuments();
    } 

    if (snapshot != null && snapshot.documents.isNotEmpty) {
      _lastVisible = snapshot.documents[snapshot.documents.length - 1];

      snapshot.documents.forEach(
        (DocumentSnapshot dateData) {
          dateIdeas = DateIdeas(
              chosenDate: dateData['chosenDate'],
              otherIdeas: dateData['otherIdeas'],
              randomEmoji: dateData['randomEmoji']);

          fetchedDateIdeas.add(dateIdeas);
        },
      );
      dateIdeasList = fetchedDateIdeas;
    } 

    if (snapshot.documents.isEmpty) {
      _errorHandling();
    }
    _isLoading = false;
    notifyListeners();
    return snapshot.documents;
  }
}
