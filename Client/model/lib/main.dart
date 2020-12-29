import 'dart:math';
import 'package:scoped_model/scoped_model.dart';
import './dates_around.dart';
import './ideas.dart';

class MainModel extends Model with IdeasModel, DatesAroundModel {
  /// Will generate a random int to a maximum of
  /// what was passed through as a param.
  int generateRandomInt(int maxNumber) {
    return Random().nextInt(maxNumber);
  }
}
