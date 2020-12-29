import 'dart:math';

class RandomDate {
  RandomDate({this.date});

  String date;

  factory RandomDate.fromServerMap(dynamic data) {
    return RandomDate(date: data['date']);
  }
}
