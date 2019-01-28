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
        bool _isPersonOneListFull =
            model.resultPersonOne == null || model.resultPersonOne.isEmpty;
        bool _isPersonTwoListFull =
            model.resultPersonTwo == null || model.resultPersonTwo.isEmpty;

        return Column(
          //        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildPersonOneButton(model, _isPersonOneListFull),
            SizedBox(
              height: 1.0,
            ),
             _buildPersonTwoButton(model, _isPersonTwoListFull),
          ],
        );
      },
    );
  }

  Widget _buildPersonOneButton(model, _isPersonOneListFull) {
    return Expanded(
      child: Material(
        textStyle: TextStyle(color: _isPersonOneListFull ? Colors.white : Colors.white,),
        color: _isPersonOneListFull ? Colors.red : Colors.greenAccent[700],
        child: InkWell(
          onTap: () => _isPersonOneListFull
              ? _navigateToEditPersonOne(context, model)
              : null,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _isPersonOneListFull
                    ? Icon(Icons.person_add, color: Colors.white,)
                    : Icon(Icons.person, color: Colors.white,),
                Text('Person One')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonTwoButton(model, _isPersonTwoListFull) {
    return Expanded(
      child: Material(
        textStyle: TextStyle(color: Colors.white,),
        color: _isPersonTwoListFull ? Colors.red : Colors.greenAccent[700],
        child: InkWell(
          onTap: () => _isPersonTwoListFull
              ? _navigateToEditPersonTwo(context, model)
              : null,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _isPersonTwoListFull
                      ? Icon(Icons.person_add, color: Colors.white,)
                      : Icon(Icons.person, color: Colors.white,),
                  Text('Person Two')
                ]),
          ),
        ),
      ),
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
