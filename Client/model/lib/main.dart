import 'package:model/base.dart';
import 'package:model/get_a_room.dart';
import 'package:model/random_idea.dart';
import 'package:model/system.dart';
import 'package:scoped_model/scoped_model.dart';

import './dates_around.dart';
import './ideas.dart';

class MainModel extends Model
    with
        BaseModel,
        IdeasModel,
        DatesAroundModel,
        RandomIdeaModel,
        GetARoomModel,
        SystemModel {}
