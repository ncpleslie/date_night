import 'package:flutter/material.dart';

class GetARoom {
  GetARoom({@required this.roomId});

  final String roomId;

  factory GetARoom.fromServerMap(dynamic data) {
    return GetARoom(roomId: data['roomId'] ?? null);
  }
}
