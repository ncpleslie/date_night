import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:api/main.dart';
import './ideas.dart';
import 'models/get_a_room_model.dart';

/// Requires that a Firestore emulator is running locally.
/// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
const bool USE_FIRESTORE_EMULATOR = false;

mixin GetARoomModel on IdeasModel {
  String roomId;
  StreamSubscription<DocumentSnapshot> roomSnapshot;
  List<dynamic> chosenIdeas;

  Future<String> getARoom() async {
    roomId = null;
    print('Over here');
    final Map<String, dynamic> getARoomResponse = await ApiSdk.getARoom();
    GetARoom roomResponse = GetARoom.fromServerMap(getARoomResponse);
    roomId = roomResponse.roomId;
    print(roomId);
    await initFirebase();
    await queryARoom();
    return roomId;
  }

  Future<bool> setARoom(String roomId) async {
    this.roomId = roomId;
    await initFirebase();
    DocumentSnapshot results = await FirebaseFirestore.instance
        .collection('get_a_room')
        .doc(roomId)
        .get();
    await queryARoom();
    return results.exists;
  }

  Future<void> initFirebase() async {
    await Firebase.initializeApp();

    if (USE_FIRESTORE_EMULATOR) {
      FirebaseFirestore.instance.settings = Settings(
          host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
    }
  }

  Future<void> queryARoom() async {
    try {
      roomSnapshot.cancel();
    } catch (error) {
      print('roomSnapshot is not initilised');
    }

    roomSnapshot = FirebaseFirestore.instance
        .collection('get_a_room')
        .doc(roomId)
        .snapshots()
        .listen((querySnapshot) {
      print('Listening');
      print(querySnapshot.data());
    });
  }
}
