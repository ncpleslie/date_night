class DateResponse {
  DateResponse({this.chosenIdea});

  final String chosenIdea;

  factory DateResponse.fromServerMap(dynamic data) {
    return DateResponse(chosenIdea: data['chosenIdea']);
  }
}
