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
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              SelectionButton(),
              SizedBox(height: 20.0,),
              model.chosenDateIdeas.length != 0
                  ? Column(children: <Widget>[_buildResultsButton(model), SizedBox(height: 30.0,), _buildClearResultsButton(model)])
                  : Container(),
            ]),
          ),
        );
      },
    );
  }

 Widget _buildResultsButton(model) {
    return CupertinoButton(
      color: Theme.of(context).buttonColor,
      child: Text('DONE?'),
      onPressed: () {
        String returningValue = model.compareAllIdeas();
        _showResults(returningValue);
      },
    );
  }

  Widget _buildClearResultsButton(model) {
    return CupertinoButton(
    child: Icon(CupertinoIcons.delete),
    onPressed: () {
      model.clearAllLists();
      setState(() {
              
            });
    },);
  }

  _showResults(returningValue) {
    Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) {
      return Results(returningValue);
    }));
  }
}
