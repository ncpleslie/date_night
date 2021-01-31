import 'dart:async';

import 'package:api/main.dart';
import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/models/date_around_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class DatesAroundViewModel extends StreamViewModel<List<DateAroundModel>> {
  final NavigationService _navigationService = locator<NavigationService>();
  
  StreamController<List<Map<String, dynamic>>> _controller;
  Stream<List<DateAroundModel>> _stream;

  List<DateAroundModel> get dates => data;
  
    @override
  Stream<List<DateAroundModel>> get stream => _stream;

  DatesAroundViewModel() {
    print('Querying external source 1');
    _data = List<Map<String, dynamic>>();
    _controller = StreamController<List<Map<String, dynamic>>>.broadcast();
    _isLoading = false;
    _stream = _controller.stream.map(
        (List<Map<String, dynamic>> datesAroundData) => datesAroundData
            .map((Map<String, dynamic> dateAround) =>
                DateAroundModel.fromServerMap(dateAround))
            .toList());

    hasMore = true;
    refresh();
    notifyListeners();
  }



  bool hasMore;

  bool _isLoading = false;
  List<Map<String, dynamic>> _data;

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
      final Map<String, dynamic> response = await MockApiSdk.getDatesAround();
      // final Map<String, dynamic> response = _data.isNotEmpty
      //     ? await MockApiSdk.getDatesAround( _data[_data.length - 1]['id'])
      //     : await MockApiSdk.getDatesAround();

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

  Future navigateToSettings() async {
    await _navigationService.navigateTo(Routes.settingsView);
  }
}
