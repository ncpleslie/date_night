import 'dart:async';

import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BootViewModel extends FutureViewModel<void> {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential _userCredential;
  String _idToken;

  UserCredential get getUser => _userCredential;
  String get userToken => _idToken;

  @override
  Future<void> futureToRun() => signInAnon();

  Future<void> signInAnon() async {
    print('Querying external source 12');
    try {
      await Firebase.initializeApp();
      _userCredential = await _firebaseAuth.signInAnonymously();
      _idToken = await _userCredential.user.getIdToken();
      await _navigationService.replaceWith(Routes.homeView);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    print('Querying external source 13');
    await _firebaseAuth.signOut();
  }
}
