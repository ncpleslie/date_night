class DateRequest {
  DateRequest({this.dateIdeas, this.isPublic = true});
  List<String> dateIdeas;
  bool isPublic;

  Map<String, dynamic> toJson() => {'dateIdeas': dateIdeas, 'isPublic': isPublic};
}
