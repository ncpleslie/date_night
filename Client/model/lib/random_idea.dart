import 'package:api/main.dart';
import './ideas.dart';
import 'models/random_date_model.dart';

mixin RandomIdeaModel on IdeasModel {
  /// Get a random date idea.
  Future<String> randomIdea() async {
    final Map<String, dynamic> response = await ApiSdk.getRandomDate();
    final RandomDate randomDate = RandomDate.fromServerMap(response);
    return randomDate.date;
  }
}
