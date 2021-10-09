import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_night/app/locator.dart';
import 'package:date_night/models/date_request_model.dart';
import 'package:date_night/models/date_response_model.dart';
import 'package:date_night/models/get_a_room_model.dart';
import 'package:date_night/models/get_a_room_response_model.dart';
import 'package:date_night/services/api_service.dart';
import 'package:date_night/services/plan_a_date_base_service.dart';
import 'package:date_night/services/realtime_db_service.dart';
import 'package:date_night/services/user_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PlanADateMultiService {
  final PlanADateBaseService _planADateBaseService = locator<PlanADateBaseService>();
  final RealtimeDBService _realtimeDBService = locator<RealtimeDBService>();
  final UserService _userService = locator<UserService>();
  final ApiService _apiService = locator<ApiService>();

  bool isMultiEditing = false;
  bool isRoomHost = false;
  late String? roomId;
  late Stream<DocumentSnapshot> roomSnapshot;
  List<String> chosenIdeas = [];
  List<String> usersChosenIdeas = [];
  late DateResponse dateMultiResponse;

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
    // Determine result
    // Combine lists
    // If value in there twice, that is the answer
    // Else return random answer
    // Clear lists
    if (isRoomHost) {
      print('EXTERNAL: Calculating results');
      await _realtimeDBService.updateRoomById(roomId!, {'gettingResults': true});

      try {
        final Map<String, dynamic> response = await _apiService.postDate(DateRequest(dateIdeas: chosenIdeas));

        dateMultiResponse = DateResponse.fromServerMap(response);

        await _realtimeDBService.updateRoomById(roomId!, {
          'chosenIdea': dateMultiResponse.chosenIdea,
        });

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
    print('EXTERNAL: Waiting for results from host');

    final completer = Completer<bool>();
    roomSnapshot.listen((querySnapshot) {
      Map<String, Object> snapshotData = querySnapshot.data() as Map<String, Object>;

      if (snapshotData['chosenIdea'] != null) {
        dateMultiResponse = DateResponse.fromServerMap(querySnapshot.data());
        clearAllMultiLists();
        completer.complete(true);
      }
    });

    return completer.future;
  }

  /// Will ask the backend to delete the current room.
  void deleteRoom() async {
    print('EXTERNAL: Deleting room with ID: $roomId');
    await _apiService.deleteARoom(roomId!);
  }

  Future<bool> waitForHost() async {
    print('EXTERNAL: Listening for host to continue');

    final completer = Completer<bool>();

    roomSnapshot.listen((querySnapshot) {
      Map<String, Object> snapshotData = querySnapshot.data() as Map<String, Object>;
      
      if (snapshotData['gettingResults'] != null && snapshotData['gettingResults'] != null) {
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
       Map<String, Object> snapshotData = querySnapshot.data() as Map<String, Object>;

      GetARoomResponse getARoomResponse = GetARoomResponse.fromServerMap(snapshotData);
      chosenIdeas = getARoomResponse.chosenIdeas;
      callback();
    });
  }

  Future<void> commitMultiIdeas() async {
    print('EXTERNAL: Adding ideas to multi date');

    await _realtimeDBService.addIdeas(roomId!, usersChosenIdeas);

    if (!isRoomHost) {
      String? userId = await _userService.getUserId();
      await _realtimeDBService.addContributorId(roomId!, userId!);
    }
  }

  Future<String?> getARoom() async {
    print('EXTERNAL: Getting room code');

    roomId = null;
    try {
      final Map<String, dynamic> getARoomResponse = await _apiService.getARoom();

      GetARoom roomResponse = GetARoom.fromServerMap(getARoomResponse);

      roomId = roomResponse.roomId;
      await queryARoom();

      return roomId;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> setARoom(String roomId) async {
    print('EXTERNAL: Finding and setting room');

    this.roomId = roomId.toLowerCase();
    DocumentSnapshot results = await _realtimeDBService.getRoomById(this.roomId!);
    await queryARoom();

    return results.exists;
  }

  Future<void> queryARoom() async {
    print('EXTERNAL: Getting DB Snapshot');
    _planADateBaseService.isMultiEditing = true;

    roomSnapshot = _realtimeDBService.getRoomSnapshotById(roomId!);
  }

  Future<int> getTotalUsersFinished() async {
    print('EXTERNAL: Getting total contributors Snapshot');

    var contributors = await _realtimeDBService.getAllContributors(roomId!);
    print(contributors);

    String? userId = await _userService.getUserId();
    contributors.removeWhere((contributor) => contributor as String == userId);

    return contributors.length;
  }
}
