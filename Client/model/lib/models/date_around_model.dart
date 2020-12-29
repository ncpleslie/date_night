class DateAroundModel {
  DateAroundModel({this.chosenDate, this.otherIdeas, this.datePosted});

  final String chosenDate;
  final List<dynamic> otherIdeas;
  final DateTime datePosted;

  factory DateAroundModel.fromServerMap(dynamic data) {
    return DateAroundModel(
        chosenDate: data['chosenDate'],
        otherIdeas: data['otherIdeas'],
        datePosted: data['datePosted']);
  }
}
