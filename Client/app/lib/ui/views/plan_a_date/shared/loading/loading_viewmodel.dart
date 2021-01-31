import 'package:stacked/stacked.dart';

class LoadingViewModel extends FutureViewModel<void> {
  @override
  Future futureToRun() => getResults();

  Future<void> getResults() async {}
}
