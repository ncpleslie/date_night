import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../scoped-models/ideas_model.dart';

class PersonOneDateEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonOneDateEditState();
  }
}

class _PersonOneDateEditState extends State<PersonOneDateEdit> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IdeasModel>(
      builder: (BuildContext context, Widget widget, IdeasModel model) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: _addBackgroundToBody(model),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Row(
              mainAxisAlignment: model.listOfDateStrings.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceAround,
              children: <Widget>[_buildAddIdeaFAB(), _buildFinishFAB(model)]),
        );
      },
    );
  }

  Widget _addBackgroundToBody(IdeasModel model) {
    final Color gradientStart = Colors.deepPurple[700];
    final Color gradientEnd = Colors.purple[500];
    final List<double> _stops = <double>[0.0, 1.0];
    final List<Color> _colors = <Color>[gradientStart, gradientEnd];
    return Container(
      child: SafeArea(
        top: true,
        bottom: true,
        child: _buildPage(model),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: const FractionalOffset(0.0, 0.5),
            end: const FractionalOffset(0.5, 0.0),
            stops: _stops,
            colors: _colors,
            tileMode: TileMode.clamp),
      ),
    );
  }

  Widget _buildPage(IdeasModel model) {
    return Center(
      child: model.listOfDateStrings.isEmpty
          ? _forEmptyList()
          : ListView.builder(
              itemCount: model.listOfDateStrings.length,
              itemBuilder: (BuildContext context, int index) {
                return _makeCards(model, index);
              },
            ),
    );
  }

  Widget _makeCards(IdeasModel model, int index) {
    return Dismissible(
      key: Key(model.listOfDateStrings[index]),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          model.listOfDateStrings.removeAt(index);
          setState(() {});
        }
      },
      child: _buildCardContent(model, index),
    );
  }

  Widget _buildCardContent(IdeasModel model, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(children: <Widget>[
        ListTile(
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                  model.listOfDateStrings[index],
                  minFontSize: 20.0,
                  maxLines: 3,
                )
              ]),
        ),
        ButtonTheme.bar(
          child: ButtonBar(children: <IconButton>[
            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.star_border),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                model.listOfDateStrings.removeAt(index);
                setState(() {});
              },
            ),
          ]),
        )
      ]),
    );
  }

  Widget _buildAddIdeaFAB() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton(
          heroTag: 'Add More',
          backgroundColor: CupertinoColors.activeBlue,
          elevation: 0,
          child: const Icon(Icons.add, size: 30),
          onPressed: () {
            _showInput();
          },
        ),
        const SizedBox(
          height: 40.0,
        )
      ],
    );
  }

  Widget _buildFinishFAB(IdeasModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        model.listOfDateStrings.isEmpty
            ? Container(
                width: 0.0,
                height: 0.0,
              )
            : FloatingActionButton(
                heroTag: 'Continue',
                backgroundColor: CupertinoColors.activeBlue,
                elevation: 0,
                child: const Icon(
                  CupertinoIcons.check_mark,
                  size: 50,
                ),
                onPressed: () => _finishFABLogic(model),
              ),
        const SizedBox(
          height: 40.0,
        )
      ],
    );
  }

  void _finishFABLogic(IdeasModel model) {
    if (model.listOfDateStrings.isNotEmpty) {
      if (model.isPersonOneEditing) {
        model.addPersonOneIdeas(model.listOfDateStrings);
        model.listOfDateStrings.clear();
        model.isPersonOneEditing = false;
        setState(() {});
      } else if (model.isPersonTwoEditing) {
        model.addPersonTwoIdeas(model.listOfDateStrings);
        model.listOfDateStrings.clear();
        model.isPersonTwoEditing = false;
        setState(() {});
      }
      Navigator.pop(context);
    }
  }

  Future<void> _showInput() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return ScopedModelDescendant<IdeasModel>(
          builder: (BuildContext context, Widget child, IdeasModel model) {
            return GestureDetector(
              // If the user taps outside form boxes then the keyboard is minimized
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                title: const Text('Date Idea?'),
                content: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  maxLines: 3,
                  controller: _textController,
                  autofocus: true,
                ),
                actions: <Widget>[
                  FlatButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    color: Theme.of(context).primaryColor,
                    child: const Text('Add Idea'),
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        final String ideas = _textController.text
                            .replaceFirst(RegExp(r'^\s+'), '');
                        model.dateIdeaEntries(ideas);
                        _textController.text = '';
                        Navigator.of(context, rootNavigator: true)
                            .pop('Continue');
                        setState(() {});
                      }
                    },
                  ),
                  FlatButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    color: Theme.of(context).primaryColor,
                    child: const Text('Discard'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('Discard');
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _forEmptyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Icon(CupertinoIcons.search),
        Text('No Ideas Yet?'),
      ],
    );
  }
}