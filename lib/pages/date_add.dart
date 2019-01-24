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
        return CupertinoPopupSurface(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.70,
                child: count == 0
                    ? _forEmptyList()
                    : ListView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: targetPadding / 2),
                        itemCount: _listOfTextInputs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Widget widget = _buildPageContent(context, index);

                          return widget;
                        },
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: _buildFAB(),
              )
            ],
          ),
        );
      },
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
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Padding(padding: EdgeInsets.all(10.0),),
                Container(
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).buttonColor,
                    elevation: 0,
                    child: Icon(Icons.add, size: 30),
                    onPressed: () {
                      _showInput();
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0),),
                // Move On Button
                Container(
                  child: count == 0
                      ? Container()
                      : FloatingActionButton(
                          backgroundColor: Theme.of(context).buttonColor,
                          elevation: 0,
                          child: Icon(CupertinoIcons.check_mark, size: 50,),
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
            child: _SystemPadding(
              child: CupertinoAlertDialog(
                title: Text('Date Idea?'),
                content: CupertinoTextField(
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  maxLines: 4,
                  controller: _textController,
                  autofocus: true,
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Add Idea'),
                    isDefaultAction: true,
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        String ideas = (_textController.text);
                        _listOfTextStrings.add(ideas);
                        _listOfTextInputs.add(_buildDateIdeaCard());
                        _textController.text = '';
                        count++;
                        Navigator.of(context, rootNavigator: true)
                            .pop("Continue");
                        setState(() {});
                      }
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text('Discard'),
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop("Discard");
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}

// Bug fix for AlertDialogs being covered with Software Keyboard
// https://stackoverflow.com/questions/46841637/show-a-text-field-dialog-without-being-covered-by-keyboard
//
class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
