class DateRequest {
  DateRequest({this.dateIdeas});
  List<List<String>> dateIdeas;

  Map<String, dynamic> toJson() =>
      {'dateIdeas': dateIdeas.expand((i) => i).toList()};
}
