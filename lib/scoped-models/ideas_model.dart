import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import "dart:math";
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/date_ideas.dart';
import '../globals/globals.dart';

class IdeasModel extends Model {
  List chosenDateIdeas = [];
  List personOneIdeas = [];
  List personTwoIdeas = [];

  // From Selection_Button.dart
  List resultPersonOne = [];
  List resultPersonTwo = [];

  // For Final Selection
  String chosenIdea;

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

  void addPersonOneIdeas(List personOneIdea) {
    personOneIdeas = personOneIdea;
  }

  void addPersonTwoIdeas(List personTwoIdea) {
    personTwoIdeas = personTwoIdea;
    chosenDateIdeas = List.from(personOneIdeas)..addAll(personTwoIdeas);
    chosenDateIdeas.shuffle();
  }

  void clearAllLists() {
    chosenDateIdeas = [];
    personOneIdeas = [];
    personTwoIdeas = [];
    resultPersonOne = [];
    resultPersonTwo = [];
    notifyListeners();
  }

  // From Fetching ideas
  List dateIdeasList = [];

  List get displayedIdeas {
    return List.from(dateIdeasList);
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

    final random = new Random();

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

  Future<Null> uploadDateIdeas() async {
    
    final Map<String, dynamic> dateIdeas = {
      'chosenDate': chosenIdea,
      'otherIdeas': chosenDateIdeas,
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

  Future<Null> fetchDateIdeas() async {
    _isLoading = true;
    try {
      CollectionReference collectionRef =
          Firestore.instance.collection('date_ideas');
      final snapshot = await collectionRef.getDocuments();
      if (snapshot.documents.isNotEmpty) {
        _errorHandling();
      }

      final List fetchedDateIdeas = [];

      snapshot.documents.forEach(
        (dynamic dateData) {
          final DateIdeas dateIdeas = DateIdeas(
              chosenDate: dateData['chosenDate'],
              otherIdeas: dateData['otherIdeas']);

          fetchedDateIdeas.add(dateIdeas);
        },
      );
      dateIdeasList = fetchedDateIdeas;
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _errorHandling();
    }
  }
}
