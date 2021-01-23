import 'package:api/main.dart';
import 'package:model/base.dart';
import 'models/random_date_model.dart';

mixin RandomIdeaModel on BaseModel {
  /// Get a random date idea.
  Future<String> randomIdea() async {
    print('Querying external source 11');

    final Map<String, dynamic> response = await ApiSdk.getRandomDate(super.userToken);
    final RandomDate randomDate = RandomDate.fromServerMap(response);
    return randomDate.date;
  }
}
