import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/selection_button.dart';
import '../scoped-models/ideas_model.dart';
import '../pages/results.dart';

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
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Add Some Date Ideas'),
            trailing: _buildDeleteDataIcon(model),
          ),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SelectionButton(),
                  SizedBox(
                    height: 20.0,
                  ),
                  model.chosenDateIdeas.length != 0
                      ? _buildResultsButton(model)
                      : Container(),
                ]),
          ),
        );
      },
    );
  }

  Widget _buildDeleteDataIcon(model) {
    return model.chosenDateIdeas.length != 0
        ? IconButton(
            icon: Icon(CupertinoIcons.delete),
            tooltip: 'Delete',
            onPressed: () {
              model.clearAllLists();
              setState(() {});
            },
          )
        : null;
  }

  Widget _buildResultsButton(model) {
    return CupertinoButton(
      color: Theme.of(context).buttonColor,
      child: Text('DONE?'),
      onPressed: () {
        String returningValue = model.compareAllIdeas();
        _showResults(returningValue);
        model.clearAllLists();
      },
    );
  }

  Future<Null> _showResults(returningValue) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            widthFactor: MediaQuery.of(context).size.width * 0.90,
            heightFactor: MediaQuery.of(context).size.height * 0.90,
            child: Results(returningValue),
          );
        });
  }
}
