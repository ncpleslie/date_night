import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@lazySingleton
class RealtimeDBService {
  final String firebaseKey = 'get_a_room';
  Future<DocumentSnapshot> getRoomById(String roomId) async {
    return await FirebaseFirestore.instance.collection(firebaseKey).doc(roomId).get();
  }

  Stream<DocumentSnapshot> getRoomSnapshotById(String roomId) {
    return FirebaseFirestore.instance.collection(firebaseKey).doc(roomId).snapshots();
  }

  Future<void> updateRoomById(String roomId, Object updatePayload) async {
    // TODO: Make model
    await FirebaseFirestore.instance.collection(firebaseKey).doc(roomId).update(updatePayload);
  }

  Future<void> addContributorId(String roomId, String userId) async {
    await FirebaseFirestore.instance.collection(firebaseKey).doc(roomId).update({
      'contributors': FieldValue.arrayUnion([userId])
    });
  }

  Future<void> addIdeas(String roomId, List<String> ideas) async {
    await FirebaseFirestore.instance
        .collection(firebaseKey)
        .doc(roomId)
        .update({'chosenIdeas': FieldValue.arrayUnion(ideas)});
  }

  FutureOr<List<dynamic>> getAllContributors(String roomId) async {
  final completer = Completer<List<dynamic>>();

    Stream<DocumentSnapshot> document = getRoomSnapshotById(roomId);
    document.listen((querySnapshot) {
      if (querySnapshot.data()['contributors'] != null) {
        var contributors = querySnapshot.data()['contributors'];
        completer.complete(contributors);
      }
    });

    return completer.future;
  }
}
