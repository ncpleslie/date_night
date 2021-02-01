import 'package:api/main.dart';
import 'package:date_night/app/locator.dart';
import 'package:date_night/models/random_date_model.dart';
import 'package:date_night/services/user_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RandomIdeaService {
  final UserService _userService = locator<UserService>();
  /// Get a random date idea.
  Future<String> randomIdea() async {
    print('Querying external source 11');

    final Map<String, dynamic> response = await ApiSdk.getRandomDate(_userService.userToken);
    final RandomDate randomDate = RandomDate.fromServerMap(response);
    return randomDate.date;
  }
}
