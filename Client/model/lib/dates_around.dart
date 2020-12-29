import 'dart:async';
import 'package:api/main.dart';
import './ideas.dart';
import './models/date_around_model.dart';

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
    return MockApiSdk.getDatesAround()
        .then((List<Map<String, Object>> datesAroundData) {
      _isLoading = false;
      _data.addAll(datesAroundData);
      hasMore = _data.length < 3;
      _controller.add(_data);
    });
  }
}
