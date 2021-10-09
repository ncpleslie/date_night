class RandomDate {
  RandomDate({required this.date});

  String date;

  factory RandomDate.fromServerMap(dynamic data) {
    return RandomDate(date: data['idea'] ?? 'baking something');
  }
}
