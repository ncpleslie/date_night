import 'package:date_night/src/scoped_model/dates_around_model.dart';
import 'package:date_night/src/scoped_model/ideas_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with IdeasModel, DatesAroundModel {}
