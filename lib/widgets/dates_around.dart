import 'package:flutter/material.dart';

import '../scoped-models/ideas_model.dart';
import './date_card.dart';

class DatesAround extends StatefulWidget {
  final IdeasModel model;
  final dateList;
  DatesAround(this.model, this.dateList);
  @override
  State<StatefulWidget> createState() {
    return _DatesAroundState();
  }
}

class _DatesAroundState extends State<DatesAround> {


  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  _buildListView() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return DateCard(index);
      },
      itemCount: widget.model.displayedIdeas.length,
    );
  }
}
