import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';

/// Requires that a Firestore emulator is running locally.
/// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
const bool USE_FIRESTORE_EMULATOR = false;

mixin BaseModel on Model {
  Future<void> initFirebase() async {
    print('Initialising Firebase');
    await Firebase.initializeApp();

    if (USE_FIRESTORE_EMULATOR) {
      FirebaseFirestore.instance.settings = Settings(
          host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
    }
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential _userCredential;
  UserCredential get getUser => _userCredential;
  String _idToken;
  String get userToken => _idToken;

  Future<User> signInAnon() async {
    print('Querying external source 12');

    try {
      _userCredential = await _firebaseAuth.signInAnonymously();
      _idToken = await _userCredential.user.getIdToken();
      return _userCredential.user;
    } catch (e) {
      throw e;
    }
  }

  void signOut() {
    print('Querying external source 13');

    _firebaseAuth.signOut();
  }

  /// Will generate a random int to a maximum of
  /// what was passed through as a param.
  int generateRandomInt(int maxNumber) {
    return Random().nextInt(maxNumber);
  }
}
