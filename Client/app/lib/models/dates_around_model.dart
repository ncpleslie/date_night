class DateAroundModel2 {
  DateAroundModel2({this.chosenIdea, this.otherIdeas, this.date, this.id});

  final String chosenIdea;
  final List<dynamic> otherIdeas;
  final DateTime date;
  final String id;

  factory DateAroundModel2.fromServerMap(dynamic data) {
    return DateAroundModel2(
      chosenIdea: data['chosenIdea'] ?? 'Server Error',
      otherIdeas: data['otherIdeas'] ?? [''],
      date: DateTime.parse(data['date']).toLocal() ?? DateTime.now(),
      id: data['id'] ?? null,
    );
  }
}
