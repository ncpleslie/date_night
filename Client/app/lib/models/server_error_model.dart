class ServerErrorModel {
  ServerErrorModel({required this.error, required this.errorCode});

  final String error;
  final int errorCode;

  factory ServerErrorModel.fromServerMap(dynamic data) {
    assert(data['error'] != null);
    return ServerErrorModel(error: data['error'], errorCode: data['errorCode']);
  }
}
