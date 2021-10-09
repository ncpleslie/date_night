import 'package:date_night/config/shared_preferences_index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class UserService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late UserCredential? _userCredential;

  Future<String?> get userToken async {
    print('Getting anonymous user\'s token');

    if (_userCredential == null) {
      throw Exception("User Credentials not set");
    }

    return await _userCredential?.user!.getIdToken();
  }

  Future<void> signIn() async {
    print('Signing in anonymously');
    try {
      _userCredential = await _firebaseAuth.signInAnonymously();
      await _userCredential?.user!.getIdToken();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    print('Signing anonymous user out');
    await _firebaseAuth.signOut();
  }

  Future<void> signOutAndDelete() async {
    if (_userCredential == null) {
      throw Exception("User Credentials not set");
    }

    _userCredential?.user!.delete();
  }

  Future<void> setPublic(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedPreferencesIndex.PUBLIC, value);
  }

  Future<bool> getPublic() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferencesIndex.PUBLIC) ?? true;
  }

  Future<String?> getUserId() async {
    if (_userCredential == null) {
      throw Exception('User must be initialised');
    }

    return _userCredential?.user?.uid;
  }
}
