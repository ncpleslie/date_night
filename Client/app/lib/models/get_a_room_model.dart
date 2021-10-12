class GetARoom {
  GetARoom({required this.roomId});

  final String roomId;

  factory GetARoom.fromServerMap(dynamic data) {
    assert(data['roomId'] != null);
    return GetARoom(roomId: data['roomId']);
  }
}
