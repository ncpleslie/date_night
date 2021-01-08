import 'package:date_night/src/widgets/custom_fab.dart';
import 'package:date_night/src/widgets/date_add_dialog.dart';
import 'package:date_night/src/widgets/date_add_idea_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:model/main.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/empty_screen_icon.dart';
import '../../widgets/page_background.dart';

/// DateAdd allows the user to add a new date.
/// The user can tap the "add" button to enter new ideas.
/// They can swipe away bad ideas, or tap delete.
/// Once they have finished they can tap the finish icon to
/// return back to the 'Plan A Date' screen.
class DateAddSingle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget widget, MainModel model) {
        _getRandomDate(model);
        return Scaffold(
          // Build Appbar
          appBar: CustomAppBar(name: '').build(context),
          resizeToAvoidBottomPadding: false,

          // Create body
          body: PageBackground(child: _buildPage(model)),

          // FAB
          floatingActionButton: Row(
            mainAxisAlignment: !model.isCurrentEditorsListValid()
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomFAB(
                  tag: 'Add More',
                  icon: Icons.add,
                  onTap: () => _showInput(context, model)),
              !model.isCurrentEditorsListValid()
                  ? Container(
                      width: 0.0,
                      height: 0.0,
                    )
                  : CustomFAB(
                      tag: 'Continue',
                      icon: CupertinoIcons.check_mark,
                      onTap: () => _finish(context, model),
                    )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Future<String> _getRandomDate(MainModel model) async {
    return await model.randomIdea();
  }

  /// Builds the list of ideas the user entered.
  Widget _buildPage(MainModel model) {
    String emptyIconString = 'No ideas yet?';
    return FutureBuilder<String>(
      future: _getRandomDate(model),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          emptyIconString = 'No ideas yet?\nHow about ${snapshot.data}?';
        }
        return Center(
          child: !model.isCurrentEditorsListValid()
              ? EmptyScreenIcon(emptyIconString, CupertinoIcons.search)
              : ListView.builder(
                  itemCount: model.getCurrentEditorsIdeasList().length,
                  itemBuilder: (BuildContext context, int index) {
                    return DateAddIdeaCard(
                        model: model,
                        index: index,
                        name: model.getCurrentEditorsIdeasList()[index],
                        onDelete: _remove);
                  },
                ),
        );
      },
    );
  }

  /// Moves the user back a screen.
  void _finish(BuildContext context, MainModel model) {
    if (model.isCurrentEditorsListValid()) {
      Navigator.pop(context);
    }
  }

  /// Removes the date idea from potential dates.
  void _remove(MainModel model, int index) {
    model.removeItemAt(index);
  }

  /// Shows the dialog box to allow the user to enter their ideas.
  Future<void> _showInput(BuildContext context, MainModel model) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return DateAddDialog(
          model: model,
        );
      },
    );
  }
}
