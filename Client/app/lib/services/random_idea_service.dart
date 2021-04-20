import 'package:date_night/app/locator.dart';
import 'package:date_night/models/random_date_model.dart';
import 'package:date_night/services/api_service.dart';
import 'package:date_night/services/user_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RandomIdeaService {
  final UserService _userService = locator<UserService>();
  final ApiService _apiService = locator<ApiService>();
  
  /// Get a random date idea.
  Future<String> randomIdea() async {
    print('Querying external source 11');

    final Map<String, dynamic> response = await _apiService.getRandomDate(_userService.userToken);
    final RandomDate randomDate = RandomDate.fromServerMap(response);
    return randomDate.date;
  }
}
