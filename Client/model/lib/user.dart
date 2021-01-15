import 'package:firebase_auth/firebase_auth.dart';
import 'ideas.dart';

mixin UserModel on IdeasModel {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User> signInAnon() async {
    print('Querying external source 12');

    UserCredential result = await firebaseAuth.signInAnonymously();
    return result.user;
  }

  void signOut() {
    print('Querying external source 13');

    firebaseAuth.signOut();
  }
}
