import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StartUpService {
  Future<void> init() async {
    await Firebase.initializeApp();
  }
}
