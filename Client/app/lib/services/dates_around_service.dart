import 'package:injectable/injectable.dart';

@lazySingleton
class DatesAroundService {
  void reportDate(String id) {
    print('Reported: $id');
  }
}