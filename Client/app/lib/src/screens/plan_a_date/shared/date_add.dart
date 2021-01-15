import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/widgets/custom_fab.dart';
import 'package:date_night/src/widgets/date_add_dialog.dart';
import 'package:date_night/src/widgets/date_add_idea_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:model/main.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/empty_screen_icon.dart';
import '../../../widgets/page_background.dart';

/// DateAdd allows the user to add a new date.
/// The user can tap the "add" button to enter new ideas.
/// They can swipe away bad ideas, or tap delete.
/// Once they have finished they can tap the finish icon to
/// return back to the 'Plan A Date' screen.
// ignore: must_be_immutable
class DateAdd extends StatelessWidget {
  bool isListValid(model) {
    return model.isMultiEditing
        ? model.isMultiEditorsListValid()
        : model.isCurrentEditorsListValid();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget widget, MainModel model) {
        return Scaffold(
          // Build Appbar
          extendBodyBehindAppBar: model.isMultiEditing ? false : true,
          appBar: CustomAppBar(
            name: model.isMultiEditing ? 'Room code: ${model.roomId}' : '',
            transparent: model.isMultiEditing ? false : true,
          ).build(context),
          resizeToAvoidBottomPadding: false,

          // Create body
          body: PageBackground(child: _buildPage(model)),

          // FAB
          floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: isListValid(model)
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.center,
              children: <Widget>[
                CustomFAB(
                    tag: 'Add More',
                    icon: Icons.add,
                    onTap: () => _showInput(context, model)),
                isListValid(model)
                    ? CustomFAB(
                        tag: 'Continue',
                        icon: CupertinoIcons.check_mark,
                        onTap: () => _finish(context, model),
                      )
                    : Container(
                        width: 0.0,
                        height: 0.0,
                      )
              ],
            ),
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
            child: isListValid(model)
                ? ListView.builder(
                    itemCount: _editorsList(model).length,
                    itemBuilder: (BuildContext context, int index) {
                      return DateAddIdeaCard(
                          model: model,
                          index: index,
                          name: _editorsList(model)[index],
                          onDelete: _remove);
                    },
                  )
                : EmptyScreenIcon(emptyIconString, CupertinoIcons.search));
      },
    );
  }

  List<String> _editorsList(MainModel model) {
    if (model.isMultiEditing) {
      return model.getMultiEditorsIdeasList();
    }
    return model.getCurrentEditorsIdeasList();
  }

  /// Moves the user back a screen.
  void _finish(BuildContext context, MainModel model) {
    if (model.isMultiEditing) {
      if (model.isMultiEditorsListValid()) {
        Navigator.of(context).popAndPushNamed(Routes.WaitingRoom);
      }
    } else {
      if (model.isCurrentEditorsListValid()) {
        Navigator.pop(context);
      }
    }
  }

  /// Removes the date idea from potential dates.
  void _remove(MainModel model, int index) {
    if (model.isMultiEditing) {
      model.removeMultiEditorsItemAt(index);
    } else {
      model.removeItemAt(index);
    }
  }

  /// Shows the dialog box to allow the user to enter their ideas.
  Future<void> _showInput(BuildContext context, MainModel model) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return DateAddDialog(
          context,
          model: model,
        );
      },
    );
  }
}
