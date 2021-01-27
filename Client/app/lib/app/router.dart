import 'package:auto_route/auto_route_annotations.dart';
import 'package:date_night/ui/views/dates_around/dates_around_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: DatesAroundView, initial: true),
])
class $Router {}
