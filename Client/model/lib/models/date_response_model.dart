class DateResponse {
  DateResponse({this.chosenIdea, this.imageURL});

  final String chosenIdea;
  final String imageURL;

  factory DateResponse.fromServerMap(dynamic data) {
    return DateResponse(
        chosenIdea: data['chosenIdea'], imageURL: data['image']);
  }
}
