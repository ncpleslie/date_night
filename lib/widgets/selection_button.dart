import 'package:flutter/material.dart';

import '../pages/person_one_date_edit.dart';

class SelectionButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectionButtonState();
  }
}

class _SelectionButtonState extends State<SelectionButton> {
  List resultPersonOne = [];
  List resultPersonTwo = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildPersonOneButton(),
          SizedBox(
            width: 30.0,
          ),
          _buildPersonTwoButton(),
        ],
      ),
    );
  }

  Widget _buildPersonOneButton() {
    return OutlineButton(
      padding: EdgeInsets.all(50.0),
      borderSide: BorderSide(
        color: resultPersonOne.length == 0
            ? Colors.red
            : Theme.of(context).accentColor,
      ),
      textColor: resultPersonOne.length == 0
          ? Colors.red
          : Theme.of(context).accentColor,
      color: resultPersonOne.length == 0
          ? Colors.red
          : Theme.of(context).accentColor,
      onPressed: () {
        _navigateToEditPersonOne(context);
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            resultPersonOne.length == 0
                ? Icon(Icons.person_add)
                : Icon(Icons.person),
            Text('Person One')
          ]),
    );
  }

  Widget _buildPersonTwoButton() {
    return OutlineButton(
      padding: EdgeInsets.all(50.0),
      borderSide: BorderSide(
        color: resultPersonTwo.length == 0
            ? Colors.red
            : Theme.of(context).accentColor,
      ),
      textColor: resultPersonTwo.length == 0
          ? Colors.red
          : Theme.of(context).accentColor,
      color: resultPersonTwo.length == 0
          ? Colors.red
          : Theme.of(context).accentColor,
      onPressed: () {
        _navigateToEditPersonTwo(context);
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            resultPersonTwo.length == 0
                ? Icon(Icons.person_add)
                : Icon(Icons.person),
            Text('Person Two')
          ]),
    );
  }

  _navigateToEditPersonOne(BuildContext context) async {
    resultPersonOne = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return PersonOneDateEdit();
    }));
  }

  _navigateToEditPersonTwo(BuildContext context) async {
    resultPersonTwo = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return PersonOneDateEdit();
    }));
  }
}
