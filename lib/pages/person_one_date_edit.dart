import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'dart:async';

import '../scoped-models/ideas_model.dart';

class PersonOneDateEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonOneDateEditState();
  }
}

class _PersonOneDateEditState extends State<PersonOneDateEdit> {
  List<Widget> _listOfTextInputs = [];
  List<String> _listOfTextStrings = List();
  int count = 0;
  int index;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double commonBreakPoint = 550.0;
    final double oddBreakPoint = 500.0;
    final double percentageMark = 0.95;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > commonBreakPoint
        ? oddBreakPoint
        : deviceWidth * percentageMark;
    final double targetPadding = deviceWidth - targetWidth;
    /*  if (count == 0) {
      Future.delayed(Duration.zero, () => _showInput());
    } */
    return ScopedModelDescendant<IdeasModel>(
      builder: (BuildContext context, Widget widget, IdeasModel model) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              height: MediaQuery.of(context).size.height - 160.0,
              margin: EdgeInsets.all(10.0),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                itemCount: _listOfTextInputs.length,
                itemBuilder: (BuildContext context, int index) {
                  Widget widget = _buildPageContent(context, index);

                  return widget;
                },
              ),
            ),
          ),
          floatingActionButton: _buildFAB(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, int index) {
    return _listOfTextInputs.elementAt(index);
  }

  Widget _buildTextField() {
    final Key _key = Key(_listOfTextStrings[count]);
    String title = _listOfTextStrings[count].toString();
    return Dismissible(
      key: _key,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart ||
            direction == DismissDirection.startToEnd) {
          count--;
          String foundValue = _key.toString().split("'")[1];

          setState(() {
            _listOfTextStrings.remove(foundValue);
          });
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(children: <Widget>[
          ListTile(
            leading: Text('${(count + 1).toString()}.'),
            title: Text(title),
          ),
          ButtonTheme.bar(
            child: ButtonBar(children: [
              FlatButton(
                child: Icon(Icons.delete),
                onPressed: () {
                  setState(() {});
                },
              ),
            ]),
          )
        ]),
      ),
    );
  }

  Widget _buildFAB() {
    return ScopedModelDescendant<IdeasModel>(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: FractionalOffset.topCenter,
              child: RaisedButton(
                child: Text('Finished?'),
                padding: EdgeInsets.symmetric(horizontal: 150.0),
                onPressed: () {
                  if (_listOfTextStrings.length != 0) {
                    if (model.personOneIdeas.length == 0) {
                      model.addPersonOneIdeas(_listOfTextStrings);
                    } else {
                      model.addPersonTwoIdeas(_listOfTextStrings);
                    }
                    Navigator.pop(context, _listOfTextStrings);
                  } else {
                    // If user doesn't enter anything
                    Scaffold.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                          SnackBar(content: Text('Please Enter Some Ideas')));
                  }
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Icon(Icons.add),
              padding: EdgeInsets.symmetric(horizontal: 170.0, vertical: 20.0),
              onPressed: () {
                _showInput();
              },
            )
          ],
        );
      },
    );
  }

  Future<Null> _showInput() async {
    await showDialog(
      context: context,
      child: GestureDetector(
        // If the user taps outside form boxes then the keyboard is minimized
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SimpleDialog(
          contentPadding: EdgeInsets.all(10.0),
          title: Text('Date Idea?'),
          children: <Widget>[
            TextField(
              maxLines: 2,
              controller: _textController,
              autofocus: true,
              decoration: InputDecoration(hintText: 'eg. Bowling?'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      String ideas = (_textController.text).toLowerCase();
                      _listOfTextStrings.add(ideas);
                      _listOfTextInputs.add(_buildTextField());
                      _textController.text = '';
                      count++;
                      Navigator.pop(context);
                      setState(() {});
                    }
                  },
                  child: Text('Add Idea'),
                ),
                SizedBox(
                  width: 10.0,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
