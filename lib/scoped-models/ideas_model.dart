import 'package:scoped_model/scoped_model.dart';
import 'package:collection/collection.dart';
import "dart:math";

class IdeasModel extends Model {
  List chosenDateIdeas = [];
  List personOneIdeas = [];
  List personTwoIdeas = [];

  void addPersonOneIdeas(List personOneIdea) {
    personOneIdeas = personOneIdea;
  }

  void addPersonTwoIdeas(List personTwoIdea) {
    personTwoIdeas = personTwoIdea;
    chosenDateIdeas = List.from(personOneIdeas)..addAll(personTwoIdeas);
  }

  String compareAllIdeas() {
    // If person one and person two enter same idea
    // return similar idea
    // else
    // return a random idea

    String chosenIdea = null;

    //compare shortest list against longest list

    if (personOneIdeas.length >= personTwoIdeas.length) {
      for (int i = 0; i <= personOneIdeas.length-1; i++) {
        for (int j = 0; j <= personTwoIdeas.length-1; j++) {
          if (personOneIdeas[i] == personTwoIdeas[j]) {
            chosenIdea = personOneIdeas[i];
          }
        }
      }
    } else {
      for (int i = 0; i <= personTwoIdeas.length-1; i++) {
        for (int j = 0; j <= personOneIdeas.length-1; j++) {
          if (personTwoIdeas[i] == personOneIdeas[j]) {
            chosenIdea = personTwoIdeas[i];
          }
        }
      }
    }

    final random = new Random();
    
    if (chosenIdea == null) {
      chosenIdea = chosenDateIdeas[random.nextInt(chosenDateIdeas.length)].toString();
    }

    return chosenIdea;
  }
}
