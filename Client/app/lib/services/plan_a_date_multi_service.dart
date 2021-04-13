import 'dart:async';

import 'package:api/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_night/app/locator.dart';
import 'package:date_night/models/date_request_model.dart';
import 'package:date_night/models/date_response_model.dart';
import 'package:date_night/models/get_a_room_model.dart';
import 'package:date_night/models/get_a_room_response_model.dart';
import 'package:date_night/services/plan_a_date_base_service.dart';
import 'package:date_night/services/user_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PlanADateMultiService {
  final UserService _service = locator<UserService>();
  final PlanADateBaseService _planADateBaseService = locator<PlanADateBaseService>();

  bool isMultiEditing = false;
  bool isRoomHost = false;
  String roomId;
  Stream<DocumentSnapshot> roomSnapshot;
  List<String> chosenIdeas = [];
  List<String> usersChosenIdeas = [];
  DateResponse dateMultiResponse;

  bool isMultiEditorsListValid() {
    return usersChosenIdeas.isNotEmpty;
  }

  List<String> getMultiEditorsIdeasList() {
    return usersChosenIdeas;
  }

  void removeMultiEditorsItemAt(int index) {
    usersChosenIdeas.removeAt(index);
  }

  void addMultiIdea(String idea) {
    final String ideaNormalised = idea.replaceFirst(RegExp(r'^\s+'), '');
    usersChosenIdeas.add(ideaNormalised);
  }

  Future<void> calculateResults() async {
    print('Querying external source 3');

    // Determine result
    // Combine lists
    // If value in there twice, that is the answer
    // Else return random answer
    // Clear lists
    if (isRoomHost) {
      print('getting results');
      await FirebaseFirestore.instance.collection('get_a_room').doc(roomId).update({'gettingResults': true});

      final Map<String, dynamic> dateReq = DateRequest(dateIdeas: chosenIdeas).toJson();

      try {
        final Map<String, dynamic> response = await ApiSdk.postDate(_service.userToken, dateReq);

        dateMultiResponse = DateResponse.fromServerMap(response);

        // TODO: Make model
        await FirebaseFirestore.instance.collection('get_a_room').doc(roomId).update({
          'chosenIdea': dateMultiResponse.chosenIdea,
        });

        // deletion now automated
        deleteRoom();
      } catch (error) {
        throw error;
      }
    }
    clearAllMultiLists();
  }

  void clearAllMultiLists() {
    usersChosenIdeas.clear();
    isRoomHost = false;
  }

  Future<void> waitForResults() {
    print('Querying external source 4');

    print('Waiting for results');
    final completer = Completer<bool>();
    roomSnapshot.listen((querySnapshot) {
      if (querySnapshot.data()['chosenIdea'] != null) {
        dateMultiResponse = DateResponse.fromServerMap(querySnapshot.data());
        clearAllMultiLists();
        completer.complete(true);
      }
    });
    return completer.future;
  }

  /// Will ask the backend to delete the current room.
  void deleteRoom() async {
    print('Deleting room with ID: $roomId');
    await ApiSdk.deleteARoom(_service.userToken, roomId);
  }

  Future<void> waitForHost() async {
    print('Querying external source 5');

    final completer = Completer<bool>();

    roomSnapshot.listen((querySnapshot) {
      if (querySnapshot.data()['gettingResults'] != null && querySnapshot.data()['gettingResults']) {
        completer.complete(true);
      }
    });
    return completer.future;
  }

  Future<void> ideasHaveChanged(Function callback) async {
    updateChosenIdeas(() => {
          print(chosenIdeas),
          if (usersChosenIdeas.length < chosenIdeas.length) {callback(true)}
        });
  }

  void updateChosenIdeas(Function callback) {
    roomSnapshot.listen((querySnapshot) {
      GetARoomResponse getARoomResponse = GetARoomResponse.fromServerMap(querySnapshot.data());
      chosenIdeas = getARoomResponse.chosenIdeas;
      callback();
    });
  }

  Future<void> commitMultiIdeas() async {
    print('Querying external source 6');

    DocumentSnapshot results = await FirebaseFirestore.instance.collection('get_a_room').doc(roomId).get();
    print(results.data());
    GetARoomResponse getARoomResponse = GetARoomResponse.fromServerMap(results.data());
    chosenIdeas = getARoomResponse.chosenIdeas;
    await FirebaseFirestore.instance.collection('get_a_room').doc(roomId).update({
      'chosenIdeas': [...chosenIdeas, ...usersChosenIdeas]
    });
  }

  Future<String> getARoom() async {
    print('Querying external source 7');

    roomId = null;
    try {
      final Map<String, dynamic> getARoomResponse = await ApiSdk.getARoom(_service.userToken);

      GetARoom roomResponse = GetARoom.fromServerMap(getARoomResponse);

      roomId = roomResponse.roomId;
      // await super.initFirebase();
      await queryARoom();

      return roomId;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> setARoom(String roomId) async {
    print('Querying external source 8');

    this.roomId = roomId;
    // await super.initFirebase();
    DocumentSnapshot results = await FirebaseFirestore.instance.collection('get_a_room').doc(roomId).get();
    await queryARoom();

    return results.exists;
  }

  Future<void> queryARoom() async {
    print('Querying external source 9');
    _planADateBaseService.isMultiEditing = true;

    roomSnapshot = FirebaseFirestore.instance.collection('get_a_room').doc(roomId).snapshots();
  }
}
