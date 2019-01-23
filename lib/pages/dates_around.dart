import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/ideas_model.dart';

import '../widgets/dates_around.dart';

class DatesAroundPage extends StatefulWidget {
  final IdeasModel model;

  DatesAroundPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _DatesAroundPageState();
  }
}

class _DatesAroundPageState extends State<DatesAroundPage> {
  @override
  void initState() {
    widget.model.fetchDateIdeas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Dates Around You'),
            ),
            child: _buildDateIdeasList());
      },
    );
  }

  Widget _buildDateIdeasList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        Widget content = Center(child: Text('No Other Dates Found'));
        if (model.displayedIdeas.length > 0) {
          content = DatesAround();
          print(model.displayedIdeas);
        }
        return RefreshIndicator(
          child: content,
          onRefresh: model.fetchDateIdeas,
        );
      },
    );
  }
}
