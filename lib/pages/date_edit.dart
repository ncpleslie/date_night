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
        return Scaffold(
          appBar: _buildAppBar(model),
          body: _buildSelectionButtons(model),
          floatingActionButton: _buildFAB(model),
        );
      },
    );
  }

  Widget _buildSelectionButtons(model) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SelectionButton(),
          ]),
    );
  }

  Widget _buildFAB(model) {
    return model.chosenDateIdeas.length != 0
        ? _buildResultsButton(model)
        : Container();
  }

  Widget _buildAppBar(model) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.deepPurple,
      toolbarOpacity: 0.7,
      actions: <Widget>[
        _buildDeleteDataIcon(model),
      ],
    );
  }

  Widget _buildDeleteDataIcon(model) {
    bool areListsEmpty = model.chosenDateIdeas.isEmpty ||
        model.resultPersonOne.isEmpty ||
        model.resultPersonTwo.isEmpty;
    return areListsEmpty
        ? IconButton(
            icon: Icon(CupertinoIcons.delete),
            tooltip: 'Delete',
            onPressed: () {
              model.clearAllLists();
              setState(() {});
            },
          )
        : Container();
  }

  Widget _buildResultsButton(model) {
    return FloatingActionButton(
      child: Icon(
        CupertinoIcons.right_chevron,
        size: 40,
      ),
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
