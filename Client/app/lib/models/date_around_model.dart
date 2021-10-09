class DateAroundModel {
  DateAroundModel({required this.chosenIdea, this.otherIdeas, required this.date, required this.id});

  final String chosenIdea;
  final List<dynamic>? otherIdeas;
  final DateTime date;
  final String id;

  factory DateAroundModel.fromServerMap(dynamic data) {
    return DateAroundModel(
      chosenIdea: data['chosenIdea'] ?? 'Server Error',
      otherIdeas: data['otherIdeas'] ?? [''],
      date: DateTime.parse(data['date']).toLocal(),
      id: data['id'] ?? null,
    );
  }
}
