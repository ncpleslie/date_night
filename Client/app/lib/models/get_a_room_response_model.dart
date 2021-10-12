class GetARoomResponse {
  GetARoomResponse({required this.chosenIdeas});
  List<String> chosenIdeas;

  factory GetARoomResponse.fromServerMap(Map<String, dynamic> data) {
    return GetARoomResponse(
        chosenIdeas: (data['chosenIdeas'] as List)
            .map((item) => item as String)
            .toList());
  }
}
