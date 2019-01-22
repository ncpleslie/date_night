import 'package:scoped_model/scoped_model.dart';

class IdeasModel extends Model {
  List chosenDateIdeas = [];
  List personOneIdeas = [];
  List personTwoIdeas = [];

 void addPersonOneIdeas(List personOneIdea) {
   personOneIdeas = personOneIdea;
 }

  void addPersonTwoIdeas(List personTwoIdea) {
   personTwoIdeas = personTwoIdea;
 }

 void compareAllIdeas() {
  // If person one and person two enter same idea
  // return similar idea
  // else
  // return a random idea
  print('Ideas Model. Compare Lists');
  print(personOneIdeas);
  print(personTwoIdeas);
 }
}