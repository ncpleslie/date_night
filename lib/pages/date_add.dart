import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
    return ScopedModelDescendant<IdeasModel>(
      builder: (BuildContext context, Widget widget, IdeasModel model) {
        return Scaffold(
          body: _buildBackground(targetPadding),
        );
      },
    );
  }

  Widget _buildPage(targetPadding) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40.0,
        ),
        Expanded(
          flex: 6,
          child: count == 0
              ? _forEmptyList()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                  itemCount: _listOfTextInputs.length,
                  itemBuilder: (BuildContext context, int index) {
                    Widget widget = _buildPageContent(context, index);

                    return widget;
                  },
                ),
        ),
        Flexible(
          flex: 1,
          child: _buildFAB(),
        )
      ],
    );
  }

  Widget _buildBackground(targetPadding) {
    Color gradientStart = Colors.deepPurple[700];
    Color gradientEnd = Colors.purple[500];

    return Container(
      child: _buildPage(targetPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.5),
            end: FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            colors: [gradientStart, gradientEnd],
            tileMode: TileMode.clamp),
      ),
    );
  }

  Widget _buildPageContent(BuildContext context, int index) {
    return _listOfTextInputs.elementAt(index);
  }

  Widget _forEmptyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(CupertinoIcons.search),
        Text('No Ideas Yet?'),
      ],
    );
  }

  Widget _buildDateIdeaCard() {
    final Key _key = Key(_listOfTextStrings[count]);
    String title = _listOfTextStrings[count].toString();
    bool buttonPress = false;
    return Dismissible(
      key: _key,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart ||
            direction == DismissDirection.startToEnd) {
          String foundValue = _key.toString().split("'")[1];
          setState(() {
            _listOfTextInputs.removeAt(count - 1);
            _listOfTextStrings.remove(foundValue);
          });
          count--;
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
              IconButton(
                onPressed: () {
                  buttonPress ? buttonPress = false : buttonPress = true;
                  setState(() {});
                },
                icon: buttonPress ? Icon(Icons.star_border) : Icon(Icons.star),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  String foundValue = _key.toString().split("'")[1];
                  setState(() {
                    _listOfTextInputs.removeAt(count - 1);
                    _listOfTextStrings.remove(foundValue);
                  });
                  count--;
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
          children: <Widget>[
            Row(
              mainAxisAlignment: count != 0 ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
              children: <Widget>[
                // Add more ideas button
                Container(
                  child: FloatingActionButton(
                    heroTag: 'Add More',
                    backgroundColor: CupertinoColors.activeBlue,
                    elevation: 0,
                    child: Icon(Icons.add, size: 30),
                    onPressed: () {
                      _showInput();
                    },
                  ),
                ),
                // Move On Button
                Container(
                  child: count == 0
                      ? Container()
                      : FloatingActionButton(
                          heroTag: 'Continue',
                          backgroundColor: CupertinoColors.activeBlue,
                          elevation: 0,
                          child: Icon(
                            CupertinoIcons.check_mark,
                            size: 50,
                          ),
                          onPressed: () {
                            if (_listOfTextStrings.length != 0) {
                              if (model.personOneIdeas.length == 0) {
                                model.addPersonOneIdeas(_listOfTextStrings);
                              } else {
                                model.addPersonTwoIdeas(_listOfTextStrings);
                              }
                              Navigator.pop(context, _listOfTextStrings);
                            }
                          },
                        ),
                ),
              ],
            )
            // Add More Ideas Button
          ],
        );
      },
    );
  }

  Future<Null> _showInput() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          // If the user taps outside form boxes then the keyboard is minimized
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            title: Text('Date Idea?'),
            content: TextField(
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              maxLines: 3,
              controller: _textController,
              autofocus: true,
            ),
            actions: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                color: Theme.of(context).primaryColor,
                child: Text('Add Idea'),
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    String ideas = _textController.text
                        .replaceFirst(RegExp(r"^\s+"), "")
                        .replaceFirst(RegExp(r"\s+$"), "");
                    _listOfTextStrings.add(ideas);
                    _listOfTextInputs.add(_buildDateIdeaCard());
                    _textController.text = '';
                    count++;
                    Navigator.of(context, rootNavigator: true).pop("Continue");
                    setState(() {});
                  }
                },
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                color: Theme.of(context).primaryColor,
                child: Text('Discard'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop("Discard");
                },
              )
            ],
          ),
        );
      },
    );
  }
}
