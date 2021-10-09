class DateResponse {
  DateResponse({required this.chosenIdea});

  final String chosenIdea;

  factory DateResponse.fromServerMap(dynamic data) {
    assert(data['chosenIdea'] != null);
    
    return DateResponse(
        chosenIdea: data['chosenIdea']);
  }
}
