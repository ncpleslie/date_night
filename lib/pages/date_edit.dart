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
  List<Widget> _listOfTextInputs = List();
  List<String> _listOfTextStrings = List();
  int count = 0;
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
    return Card(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Text(_listOfTextStrings[count]),
    );
  }

  Widget _buildFAB() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton(
          heroTag: 'Submit',
          mini: true,
          child: Icon(Icons.save),
          onPressed: () {
            print(_listOfTextStrings);
          },
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
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(10.0),
        title: Text('Date Idea?'),
        children: <Widget>[
          TextField(
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
                  _listOfTextStrings.add(_textController.text);
                  _listOfTextInputs.add(_buildTextField());
                  _textController.text = '';
                  count++;
                  Navigator.pop(context);
                  setState(() {});
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
    );
  }
}
