import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../widgets/selection_button.dart';
import '../../scoped-models/ideas_model.dart';
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

  Widget _buildFAB(model) {
    bool areListsEmpty =
        model.personOneIdeas.isEmpty || model.personTwoIdeas.isEmpty;
    return !areListsEmpty ? _buildResultsButton(model) : Container();
  }

  Widget _buildAppBar(model) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: AppBar(
        title: Text('Plan A Date'),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        toolbarOpacity: 0.7,
        actions: <Widget>[
          _buildDeleteDataIcon(model),
        ],
      ),
    );
  }

  Widget _buildDeleteDataIcon(model) {
    bool areListsNotEmpty =
        model.personOneIdeas.isNotEmpty || model.personTwoIdeas.isNotEmpty;
    return areListsNotEmpty
        ? IconButton(
            icon: Icon(CupertinoIcons.delete),
            tooltip: 'Delete',
            onPressed: () {
              model.clearAllLists();
              setState(() {});
            },
          )
        : Container();
  }

  Widget _buildResultsButton(model) {
    return FloatingActionButton(
      child: Icon(
        CupertinoIcons.right_chevron,
        size: 40,
      ),
      onPressed: () {
        String returningValue = model.compareAllIdeas();
        _showResults(returningValue);
        model.clearAllLists();
      },
    );
  }

  _showResults(returningValue) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return LoadingPage(returningValue);
      },
    );
  }

  /* Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return ;
        },
      ),
    );*/

}
