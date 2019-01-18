import 'package:flutter/material.dart';

import 'dart:async';

class DateEdit extends StatefulWidget {
  final Color color;

  DateEdit(this.color);

  @override
  State<StatefulWidget> createState() {
    return _DateEditState();
  }
}

class _DateEditState extends State<DateEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
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
          _listOfTextStrings.remove(foundValue);
          setState(() {});
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(children: <Widget>[
          ListTile(
            title: Center(child: Text(title)),
          ),
          ButtonTheme.bar(
            child: ButtonBar(children: [
              FlatButton(
                child: Icon(Icons.delete),
                onPressed: () {
                  print(_listOfTextInputs[0]);
                  _listOfTextStrings.remove(title);
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: FloatingActionButton(
            heroTag: 'Submit',
            mini: true,
            child: Icon(Icons.save),
            onPressed: () {
              print(_listOfTextInputs.length);
              print(_listOfTextStrings);
            },
          ),
        ),
        FloatingActionButton(
          heroTag: 'Add More',
          child: Icon(Icons.add),
          onPressed: () {
            _showInput();
            setState(() {});
          },
        )
      ],
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
            Form(
              key: _formKey,
              child: TextFormField(
                maxLines: 2,
                controller: _textController,
                autofocus: true,
                decoration: InputDecoration(hintText: 'eg. Bowling?'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'No';
                  }
                },
              ),
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
                      _listOfTextStrings.add(_textController.text);
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
