class DateRequest {
  DateRequest({this.dateIdeas});
  List<String> dateIdeas;

  Map<String, dynamic> toJson() => {'dateIdeas': dateIdeas};
}
