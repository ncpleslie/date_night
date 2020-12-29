import 'dart:math';

import 'package:date_night/src/scoped_model/dates_around_model.dart';
import 'package:date_night/src/scoped_model/ideas_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with IdeasModel, DatesAroundModel {
  /// Will generate a random int to a maximum of
  /// what was passed through as a param.
  int generateRandomInt(int maxNumber) {
    return Random().nextInt(maxNumber);
  }
}
