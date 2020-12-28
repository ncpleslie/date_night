import 'dart:async';

import 'package:date_night/src/scoped_model/ideas_model.dart';
import '../models/date_around_model.dart';

Future<List<Map<String, Object>>> _getExampleDates(int length) {
  print('Getting Example Dates...');
  return Future<List<Map<String, Object>>>.delayed(
    const Duration(seconds: 1),
    () => List<Map<String, Object>>.generate(
      length,
      (int index) => <String, Object>{
        'chosenDate': 'Null',
        'otherIdeas': <Object>['Null', 'Null'],
        'datePosted': DateTime.now()
      },
    ),
  );
}

mixin DatesAroundModel on IdeasModel {
  Stream<List<DateAroundModel>> stream;
  bool hasMore;

  bool _isLoading;
  List<Map<String, Object>> _data;
  StreamController<List<Map<String, Object>>> _controller;

  void init() {
    _data = <Map<String, Object>>[];
    _controller = StreamController<List<Map<String, Object>>>.broadcast();
    _isLoading = false;
    stream = _controller.stream.map(
        (List<Map<String, Object>> datesAroundData) => datesAroundData
            .map((Map<String, Object> dateAround) =>
                DateAroundModel.fromServerMap(dateAround))
            .toList());
    hasMore = true;
    refresh();
  }

  Future<void> refresh() {
    return loadMore(clearCacheData: true);
  }

  Future<void> loadMore({bool clearCacheData = false}) {
    if (clearCacheData) {
      _data = <Map<String, Object>>[];
      hasMore = true;
    }

    if (_isLoading || !hasMore) {
      return Future<void>.value();
    }

    _isLoading = true;
    return _getExampleDates(1)
        .then((List<Map<String, Object>> datesAroundData) {
      _isLoading = false;
      _data.addAll(datesAroundData);
      hasMore = _data.length < 3;
      _controller.add(_data);
    });
  }
}
