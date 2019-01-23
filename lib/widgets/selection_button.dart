import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:scoped_model/scoped_model.dart';

import '../pages/date_add.dart';
import '../scoped-models/ideas_model.dart';

class SelectionButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectionButtonState();
  }
}

class _SelectionButtonState extends State<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget widget, IdeasModel model) {
        return Container(
          height: 150.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildPersonOneButton(model),
              SizedBox(
                width: 30.0,
              ),
              _buildPersonTwoButton(model),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPersonOneButton(model) {
    return OutlineButton(
      padding: EdgeInsets.all(50.0),
      borderSide: BorderSide(
        color: model.resultPersonOne.isEmpty
            ? Colors.red
            : Theme.of(context).accentColor,
      ),
      textColor:
          model.resultPersonOne.isEmpty ? Colors.red : Theme.of(context).accentColor,
      color:
          model.resultPersonOne.isEmpty ? Colors.red : Theme.of(context).accentColor,
      onPressed: () {
        _navigateToEditPersonOne(context, model);
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            model.resultPersonOne.isEmpty
                ? Icon(Icons.person_add)
                : Icon(Icons.person),
            Text('Person One')
          ]),
    );
  }

  Widget _buildPersonTwoButton(model) {
    return OutlineButton(
      padding: EdgeInsets.all(50.0),
      borderSide: BorderSide(
        color: model.resultPersonTwo.isEmpty
            ? Colors.red
            : Theme.of(context).accentColor,
      ),
      textColor:
          model.resultPersonTwo.isEmpty ? Colors.red : Theme.of(context).accentColor,
      color:
          model.resultPersonTwo.isEmpty? Colors.red : Theme.of(context).accentColor,
      onPressed: () {
        _navigateToEditPersonTwo(context, model);
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            model.resultPersonTwo.isEmpty
                ? Icon(Icons.person_add)
                : Icon(Icons.person),
            Text('Person Two')
          ]),
    );
  }

  _navigateToEditPersonOne(BuildContext context, IdeasModel model) async {
    model.resultPersonOne = await Navigator.push(context,
        CupertinoPageRoute(builder: (BuildContext context) {
      return PersonOneDateEdit();
    }));
  }

  _navigateToEditPersonTwo(BuildContext context, IdeasModel model) async {
    model.resultPersonTwo = await Navigator.push(context,
        CupertinoPageRoute(builder: (BuildContext context) {
      return PersonOneDateEdit();
    }));
  }
}
