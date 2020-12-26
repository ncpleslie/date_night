import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_model/ideas_model.dart';
import '../../widgets/selection_button.dart';
import './loading_page.dart';
import 'date_add.dart';

class DateEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DateEditState();
  }
}

class _DateEditState extends State<DateEdit> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IdeasModel>(
      builder: (BuildContext context, Widget widget, IdeasModel model) {
        return Scaffold(
          appBar: _buildAppBar(model),
          body: _buildSelectionButtons(model),
          floatingActionButton: _buildFAB(model),
        );
      },
    );
  }

  Widget _buildSelectionButtons(IdeasModel model) {
    return Column(
      children: <Widget>[
        SelectionButton(
            context,
            'Person One',
            model.isSelectedEditorsListValid(0),
            () => _navigateToEdit(model, 0)),
        const SizedBox(
          height: 1.0,
        ),
        SelectionButton(
            context,
            'Person Two',
            model.isSelectedEditorsListValid(1),
            () => _navigateToEdit(model, 1)),
      ],
    );
  }

  /// Will navigate to the correct editting page based on is currently editing
  void _navigateToEdit(IdeasModel model, int whoIsEditing) {
    model.setCurrentEditor(whoIsEditing);
    Navigator.push<void>(
      context,
      CupertinoPageRoute<void>(
        builder: (BuildContext context) {
          return PersonOneDateEdit();
        },
      ),
    );
  }

  Widget _buildFAB(IdeasModel model) {
    return model.isAllEditorsListsValid()
        ? FloatingActionButton(
            child: const Icon(
              Icons.keyboard_arrow_right,
              size: 30,
            ),
            onPressed: () {
              _showResults(model.calculateResults());
            },
          )
        : Container();
  }

  Widget _buildAppBar(IdeasModel model) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40.0),
      child: AppBar(
        title: const Text('Plan A Date'),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        toolbarOpacity: 0.7,
        actions: <Widget>[
          _buildDeleteDataIcon(model),
        ],
      ),
    );
  }

  Widget _buildDeleteDataIcon(IdeasModel model) {
    return model.isAnyEditorsListValid()
        ? IconButton(
            icon: const Icon(CupertinoIcons.delete),
            tooltip: 'Delete',
            onPressed: () {
              model.clearAllLists();
              setState(() {});
            },
          )
        : Container();
  }

  void _showResults(String returningValue) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return LoadingPage(returningValue);
      },
    );
  }
}
