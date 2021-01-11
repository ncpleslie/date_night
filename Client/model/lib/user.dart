import 'package:firebase_auth/firebase_auth.dart';
import 'ideas.dart';

mixin UserModel on IdeasModel {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User> signInAnon() async {
    UserCredential result = await firebaseAuth.signInAnonymously();
    return result.user;
  }

  void signOut() {
    firebaseAuth.signOut();
  }
}
