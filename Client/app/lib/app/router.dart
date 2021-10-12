import 'package:date_night/ui/views/boot/boot_view.dart';
import 'package:date_night/ui/views/dates_around/dates_around_view.dart';
import 'package:date_night/ui/views/home/home_view.dart';
import 'package:date_night/ui/views/plan_a_date/multi/waiting_room_view.dart';
import 'package:date_night/ui/views/plan_a_date/shared/add_date/add_date_view.dart';
import 'package:date_night/ui/views/plan_a_date/shared/loading/loading_view.dart';
import 'package:date_night/ui/views/plan_a_date/shared/results/results_view.dart';
import 'package:date_night/ui/views/settings/settings_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [
  MaterialRoute(page: BootView, initial: true),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: DatesAroundView),
  MaterialRoute(page: SettingsView),
  MaterialRoute(page: AddDateView),
  MaterialRoute(page: LoadingView),
  MaterialRoute(page: ResultsView),
  MaterialRoute(page: WaitingRoomView),
])
class Router {}
