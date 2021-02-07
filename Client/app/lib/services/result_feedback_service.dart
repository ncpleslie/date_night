import 'dart:math';

import 'package:date_night/config/strings.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResultFeedbackService {
  String getRandomFeedback() {
    return Strings
        .ResultsResponses[Random().nextInt(Strings.ResultsResponses.length)];
  }
}
