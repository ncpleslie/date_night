import 'package:date_night/config/shared_preferences_index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class UserService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential _userCredential;

  Future<String> get userToken async {
    print('refreshing token');
    return await _userCredential.user.getIdToken();
  }

  Future<void> signIn() async {
    print('Querying external source 12');
    try {
      _userCredential = await _firebaseAuth.signInAnonymously();
      await _userCredential.user.getIdToken();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    print('Querying external source 13');
    await _firebaseAuth.signOut();
  }

  Future<void> signOutAndDelete() async {
    _userCredential.user.delete();
  }

  Future<void> setPublic(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedPreferencesIndex.PUBLIC, value);
  }

  Future<bool> getPublic() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferencesIndex.PUBLIC) ?? true;
  }
}
