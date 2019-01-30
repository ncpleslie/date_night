import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import "dart:math";

import '../models/date_ideas.dart';

class IdeasModel extends Model {
  List chosenDateIdeas = [];
  List personOneIdeas = [];
  List personTwoIdeas = [];

  // Knowing who is editing
  bool isPersonOneEditing = false;
  bool isPersonTwoEditing = false;

  // For Final Selection
  String chosenIdea;

  void addPersonOneIdeas(List personOneIdea) {
    personOneIdeas.addAll(personOneIdea);
  }

  void addPersonTwoIdeas(List personTwoIdea) {
    personTwoIdeas.addAll(personTwoIdea);
  }

  void combineLists() {
    chosenDateIdeas = List.from(personOneIdeas)..addAll(personTwoIdeas);
    chosenDateIdeas.shuffle();
  }

  void clearAllLists() {
    chosenIdea = null;
    chosenDateIdeas = [];
    personOneIdeas = [];
    personTwoIdeas = [];
    notifyListeners();
  }

  // From Fetching ideas
  List dateIdeasList = [];

  List get displayedIdeas {
    return List.from(dateIdeasList);
  }

  // For adding ideas 
 final List/*<Widget>*/ listOfIdeaCards = [];
 final List<String> listOfDateStrings = [];

  List get ideaCards {
    return List.from(listOfIdeaCards);
  }

  void dateIdeaEntries(card, string) {
    listOfIdeaCards.add(card);
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
    final random = Random();

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

    final Map<String, dynamic> dateIdeas = {
      'chosenDate': chosenIdea,
      'otherIdeas': chosenDateIdeas,
      'randomEmoji': _emojiList[random.nextInt(_emojiList.length)],
      'uploadTime': DateTime.now()
    };

    Firestore.instance.runTransaction(
      (Transaction transaction) async {
        CollectionReference collectionRef =
            Firestore.instance.collection('date_ideas');
        await collectionRef.document().setData(dateIdeas);
      },
    );
  }

  void clearLastVisible() {
    _lastVisible = null;
  }

  DocumentSnapshot _lastVisible;
  List fetchedDateIdeas = [];

  Future fetchDateIdeas() async {
    _isLoading = true;

    QuerySnapshot snapshot;
    DateIdeas dateIdeas;

    if (_lastVisible == null) {
      snapshot = await Firestore.instance
          .collection('date_ideas')
          .orderBy('uploadTime', descending: true)
          .limit(5)
          .getDocuments();
    } else {
      snapshot = await Firestore.instance
          .collection('date_ideas')
          .orderBy('uploadTime', descending: true)
          .startAfter([_lastVisible['uploadTime']])
          .limit(5)
          .getDocuments();
    } 

    if (snapshot != null && snapshot.documents.length > 0) {
      _lastVisible = snapshot.documents[snapshot.documents.length - 1];

      snapshot.documents.forEach(
        (dynamic dateData) {
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
