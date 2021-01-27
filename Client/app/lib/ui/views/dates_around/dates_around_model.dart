class DateAroundModel {
  DateAroundModel({this.chosenIdea, this.otherIdeas, this.date, this.id});

  final String chosenIdea;
  final List<dynamic> otherIdeas;
  final DateTime date;
  final String id;

  factory DateAroundModel.fromServerMap(dynamic data) {
    return DateAroundModel(
      chosenIdea: data['chosenIdea'] ?? 'Server Error',
      otherIdeas: data['otherIdeas'] ?? [''],
      date: DateTime.parse(data['date']).toLocal() ?? DateTime.now(),
      id: data['id'] ?? null,
    );
  }
}
