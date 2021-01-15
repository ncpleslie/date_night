import 'dart:async';
import 'package:api/main.dart';
import './ideas.dart';
import './models/date_around_model.dart';

mixin DatesAroundModel on IdeasModel {
  Stream<List<DateAroundModel>> stream;
  bool hasMore;

  bool _isLoading = false;
  List<Map<String, dynamic>> _data;
  StreamController<List<Map<String, dynamic>>> _controller;

  void init() {
    print('Querying external source 1');
    _data = List<Map<String, dynamic>>();
    _controller = StreamController<List<Map<String, dynamic>>>.broadcast();
    _isLoading = false;
    stream = _controller.stream.map(
        (List<Map<String, dynamic>> datesAroundData) => datesAroundData
            .map((Map<String, dynamic> dateAround) =>
                DateAroundModel.fromServerMap(dateAround))
            .toList());
    hasMore = true;
    refresh();
    notifyListeners();
  }

  Future<void> refresh() {
    return loadMore(clearCacheData: true);
  }

  Future<void> loadMore({bool clearCacheData = false}) {
    print('Querying external source 2');

    if (clearCacheData) {
      _data = List<Map<String, dynamic>>();
      hasMore = true;
    }

    if (_isLoading || !hasMore) {
      return Future<void>.value();
    }
    _isLoading = true;

    if (_data.isNotEmpty) {
      return ApiSdk.getDatesAround(_data[_data.length - 1]['id'])
          .then((Map<String, dynamic> datesAroundData) {
        final List<Map<String, dynamic>> datesAround =
            datesAroundData["datesAround"].cast<Map<String, dynamic>>();
        _isLoading = false;
        _data.addAll(datesAround);
        hasMore = true;
        _controller.add(_data);
      });
    }

    return ApiSdk.getDatesAround().then((Map<String, dynamic> datesAroundData) {
      final List<Map<String, dynamic>> datesAround =
          datesAroundData["datesAround"].cast<Map<String, dynamic>>();
      _isLoading = false;
      _data.addAll(datesAround);
      hasMore = true;
      _controller.add(_data);
    });
  }

  void reportDate(String id) {
    print('Date Reported: $id');
  }
}
