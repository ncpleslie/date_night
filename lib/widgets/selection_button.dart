import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:scoped_model/scoped_model.dart';

import '../pages/secondary-pages/date_add.dart';
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
    return ScopedModelDescendant<IdeasModel>(
      builder: (BuildContext context, Widget widget, IdeasModel model) {
        final bool _isPersonOneListFull =
            model.personOneIdeas == null || model.personOneIdeas.isEmpty;
        final bool _isPersonTwoListFull =
            model.personTwoIdeas == null || model.personTwoIdeas.isEmpty;

        return Column(
          //        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildPersonOneButton(model, _isPersonOneListFull),
            const SizedBox(
              height: 1.0,
            ),
            _buildPersonTwoButton(model, _isPersonTwoListFull),
          ],
        );
      },
    );
  }

  Widget _buildPersonOneButton(IdeasModel model, bool _isPersonOneListFull) {
    return Expanded(
      child: Material(
        textStyle: TextStyle(
          color: _isPersonOneListFull ? Colors.white : Colors.white,
        ),
        color: _isPersonOneListFull ? Colors.red : Colors.greenAccent[700],
        child: InkWell(
          onTap: () =>
              _isPersonOneListFull ? _navigateToEdit(model, true, false) : null,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _isPersonOneListFull
                    ? const Icon(
                        Icons.person_add,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                const Text('Person One')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonTwoButton(
      IdeasModel model, bool _isPersonTwoListFull) {
    return Expanded(
      child: Material(
        textStyle: const TextStyle(
          color: Colors.white,
        ),
        color: _isPersonTwoListFull ? Colors.red : Colors.greenAccent[700],
        child: InkWell(
          onTap: () => _isPersonTwoListFull ? _navigateToEdit(model, false, true) : null,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _isPersonTwoListFull
                      ? const Icon(
                          Icons.person_add,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                  const Text('Person Two')
                ]),
          ),
        ),
      ),
    );
  }

  void _navigateToEdit(IdeasModel model, bool personOne, bool personTwo) {
    model.isPersonOneEditing = personOne;
    model.isPersonTwoEditing = personTwo;
    Navigator.push<Null>(
      context,
      CupertinoPageRoute<Null>(
        builder: (BuildContext context) {
          return PersonOneDateEdit();
        },
      ),
    );
  }
}
