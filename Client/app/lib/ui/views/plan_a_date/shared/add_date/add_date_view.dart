import 'package:date_night/ui/widgets/dumb_widgets/custom_app_bar.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_dialog.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_dialog_button.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_fab.dart';
import 'package:date_night/ui/widgets/dumb_widgets/empty_screen_icon.dart';
import 'package:date_night/ui/widgets/dumb_widgets/page_background.dart';
import 'package:date_night/ui/widgets/smart_widgets/date_add_idea_card/date_add_idea_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'add_date_viewmodel.dart';

/// DateAdd allows the user to add a new date.
/// The user can tap the "add" button to enter new ideas.
/// They can swipe away bad ideas, or tap delete.
/// Once they have finished they can tap the finish icon to
/// return back to the 'Plan A Date' screen.
// ignore: must_be_immutable
class AddDateView extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  bool isListValid(model) {
    return model.isMultiEditing
        ? model.isMultiEditorsListValid()
        : model.isCurrentEditorsListValid();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddDateViewModel>.nonReactive(
      viewModelBuilder: () => AddDateViewModel(),
      builder: (BuildContext context, AddDateViewModel model, Widget child) =>
          Scaffold(
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Future<String> _getRandomDate(AddDateViewModel model) async {
    // return await model.randomIdea();
  }

  /// Builds the list of ideas the user entered.
  Widget _buildPage(AddDateViewModel model) {
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
                          index: index,
                          name: _editorsList(model)[index],
                          onDelete: _remove);
                    },
                  )
                : EmptyScreenIcon(emptyIconString,
                    icon: CupertinoIcons.search));
      },
    );
  }

  List<String> _editorsList(AddDateViewModel model) {
    // if (model.isMultiEditing) {
    //   return model.getMultiEditorsIdeasList();
    // }
    // return model.getCurrentEditorsIdeasList();
  }

  /// Moves the user back a screen.
  void _finish(BuildContext context, AddDateViewModel model) {
    // if (model.isMultiEditing) {
    //   if (model.isMultiEditorsListValid()) {
    //     Navigator.of(context).popAndPushNamed(Routes.WaitingRoom);
    //   }
    // } else {
    //   if (model.isCurrentEditorsListValid()) {
    //     Navigator.pop(context);
    //   }
    // }
  }

  /// Removes the date idea from potential dates.
  void _remove(AddDateViewModel model, int index) {
    // if (model.isMultiEditing) {
    //   model.removeMultiEditorsItemAt(index);
    // } else {
    //   model.removeItemAt(index);
    // }
  }

  /// Shows the dialog box to allow the user to enter their ideas.
  Future<void> _showInput(BuildContext context, AddDateViewModel model) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          context,
          controller: _textController,
          title: 'Date Idea?',
          dialogButtons: _getDialogButtons(context, model),
        );
      },
    );
  }

  List<CustomDialogButton> _getDialogButtons(
      BuildContext context, AddDateViewModel model) {
    return [
      CustomDialogButton(context,
          icon: Icons.delete, onTap: () => _discard(context)),
      CustomDialogButton(context,
          icon: Icons.add, onTap: () => _addIdea(context, model))
    ];
  }

  /// Add the idea to list of possible dates
  void _addIdea(BuildContext context, AddDateViewModel model) {
    // if (_textController.text.isNotEmpty) {
    //   if (model.isMultiEditing) {
    //     model.addMultiIdea(_textController.text);
    //   } else {
    //     model.addIdea(_textController.text);
    //   }

    //   // Clear text from dialog.
    //   // Otherwise text will remain next time.
    //   _textController.text = '';

    //   // Remove the dialog box.
    //   Navigator.of(context, rootNavigator: true).pop('Continue');
    // }
  }

  /// Discard the date and remove the dialog box
  void _discard(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop('Discard');
  }
}
