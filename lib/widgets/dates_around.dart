import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:scoped_model/scoped_model.dart';

import '../models/date_ideas.dart';
import '../scoped-models/ideas_model.dart';
import './date_card.dart';

class DatesAround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        return _buildDateList(model.displayedIdeas);
      },
    );
  }

  Widget _buildDateList(List<dynamic> dateIdeas) {
    Widget dateCards = Container();
    if (dateIdeas.length > 0) {
      dateCards = _buildListView(dateIdeas);
    }
    return dateCards;
  }

  _buildListView(dateIdeas) {
    List<dynamic> dateIdeasReverse = dateIdeas.reversed.toList();
    return
     ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          DateCard(dateIdeasReverse[index]),
      itemCount: dateIdeas.length,
    );
  }
}
