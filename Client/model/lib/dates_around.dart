import 'dart:async';
import 'package:api/main.dart';
import 'package:model/base.dart';
import './models/date_around_model.dart';

mixin DatesAroundModel on BaseModel {
  Stream<List<DateAroundModel>> datesAroundStream;
  bool hasMore;

  bool _isLoading = false;
  List<Map<String, dynamic>> _data;
  StreamController<List<Map<String, dynamic>>> _controller;

  void init() {
    print('Querying external source 1');
    _data = List<Map<String, dynamic>>();
    _controller = StreamController<List<Map<String, dynamic>>>.broadcast();
    _isLoading = false;
    datesAroundStream = _controller.stream.map(
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

  Future<void> loadMore({bool clearCacheData = false}) async {
    print('Querying external source 2');

    if (clearCacheData) {
      _data = List<Map<String, dynamic>>();
      hasMore = true;
    }

    if (_isLoading || !hasMore) {
      return Future<void>.value();
    }
    _isLoading = true;

    try {
      final Map<String, dynamic> response = _data.isNotEmpty
          ? await ApiSdk.getDatesAround(
              super.userToken, _data[_data.length - 1]['id'])
          : await ApiSdk.getDatesAround(super.userToken);

      final List<Map<String, dynamic>> datesAround =
          response["datesAround"].cast<Map<String, dynamic>>();
          
      _isLoading = false;
      _data.addAll(datesAround);
      hasMore = true;
      _controller.add(_data);
    } catch (e) {
      _isLoading = false;
      _controller.addError(e);
    }
  }

  void reportDate(String id) {
    print('Date Reported: $id');
  }
}
