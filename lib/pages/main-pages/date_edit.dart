import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/ideas_model.dart';
import '../../widgets/selection_button.dart';
import '../secondary-pages/loading_page.dart';

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
          body: _buildSelectionButtons(),
          floatingActionButton: _buildFAB(model),
        );
      },
    );
  }

  Widget _buildSelectionButtons() {
    return SelectionButton();
  }

  Widget _buildFAB(IdeasModel model) {
    final bool areListsEmpty =
        model.personOneIdeas.isEmpty || model.personTwoIdeas.isEmpty;
    return !areListsEmpty ? _buildResultsButton(model) : Container();
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
    final bool areListsNotEmpty =
        model.personOneIdeas.isNotEmpty || model.personTwoIdeas.isNotEmpty;
    return areListsNotEmpty
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

  Widget _buildResultsButton(IdeasModel model) {
    return FloatingActionButton(
      child: const Icon(
        CupertinoIcons.right_chevron,
        size: 40,
      ),
      onPressed: () {
        final String returningValue = model.compareAllIdeas();
        _showResults(returningValue);
        model.clearAllLists();
      },
    );
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
