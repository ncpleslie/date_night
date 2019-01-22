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
          floatingActionButton: model.chosenDateIdeas.length != 0
              ? _buildFABandCompare(model)
              : _buildTextInstructions(),
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
        String returningValue = model.compareAllIdeas();
        _buildSnackBar(returningValue);
      },
    );
  }

  _buildTextInstructions() {
    return Text('Add Some Ideas');
  }

  _buildSnackBar(returningValue) {
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(returningValue)));
  }
}
