class Date {
  Date({this.chosenIdea});

  final String chosenIdea;

  factory Date.fromServerMap(dynamic data) {
    return Date(chosenIdea: data['chosenIdea']);
  }
}
