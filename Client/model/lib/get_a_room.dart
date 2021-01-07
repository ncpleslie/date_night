import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:api/main.dart';
import './ideas.dart';

mixin GetARoomModel on IdeasModel {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  void init() {
    firebaseMessaging.configure(
      onLaunch: null,
      onBackgroundMessage: null,
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
    );
    fcmSubscribe();
  }

  void fcmSubscribe() {
    firebaseMessaging.getToken().then((String token) {
      print('TOKEN');
      print(token);
    });
  }

  Future<String> getARoom() {}
}
