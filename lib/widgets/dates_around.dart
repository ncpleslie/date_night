import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../models/date_ideas.dart';
import '../scoped-models/ideas_model.dart';
import './date_card.dart';

class DatesAround extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return ScopedModelDescendant(builder: (BuildContext context, Widget child, IdeasModel model) {
        return _buildDateList(model.displayedIdeas);
      },);
    }

    Widget _buildDateList(List<dynamic> dateIdeas) {
      Widget dateCards;
      List<dynamic> dateIdeasReverse = dateIdeas.reversed.toList();
      if (dateIdeas.length > 0) {
        dateCards = ListView.builder(
          itemBuilder: (BuildContext context, int index) => DateCard(dateIdeasReverse[index]),
          itemCount: dateIdeas.length,
        );

        } else {
          dateCards = Container();
        }
        return dateCards;
      }
    }
