import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/selection_button.dart';
import '../scoped-models/ideas_model.dart';

class DateEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DateEditState();
  }
}

class _DateEditState extends State<DateEdit> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IdeasModel>(
      builder: (BuildContext context, Widget widget, IdeasModel model) {
        return Scaffold(
          body: Center(
            child: SelectionButton(),
          ),
          floatingActionButton: _buildFABandCompare(model),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  _buildFABandCompare(model) {
    return RaisedButton(
      child: Text('DONE?'),
      onPressed: () {
        model.compareAllIdeas();
      },
    );
  }
}
