import 'package:date_night/ui/widgets/dumb_widgets/custom_app_bar.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_dialog.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_dialog_button.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_fab.dart';
import 'package:date_night/ui/widgets/dumb_widgets/date_add_idea_card.dart';
import 'package:date_night/ui/widgets/dumb_widgets/empty_screen_icon.dart';
import 'package:date_night/ui/widgets/dumb_widgets/page_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'add_date_viewmodel.dart';

/// DateAdd allows the user to add a new date.
/// The user can tap the "add" button to enter new ideas.
/// They can swipe away bad ideas, or tap delete.
/// Once they have finished they can tap the finish icon to
/// return back to the 'Plan A Date' screen.
class AddDateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddDateViewModel>.reactive(
      viewModelBuilder: () => AddDateViewModel(),
      builder: (BuildContext context, AddDateViewModel vm, Widget child) =>
          Scaffold(
        // Build Appbar
        extendBodyBehindAppBar: vm.roomId.isNotEmpty ? false : true,
        appBar: CustomAppBar(
          name: vm.isMultiEditing() ? '${vm.roomId}' : '',
          transparent: vm.isMultiEditing() ? false : true,
        ).build(context),
        resizeToAvoidBottomPadding: false,

        // Create body
        body: PageBackground(child: _buildPage(vm)),

        // FAB
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomFAB(
                  tag: 'Add More',
                  icon: Icons.add,
                  onTap: () => _showInput(context, vm)),
              CustomFAB(
                tag: 'Continue',
                icon: Icons.arrow_forward,
                onTap: () => vm.onFinish(),
                disabled: !vm.isListValid(),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  /// Builds the list of ideas the user entered.
  Widget _buildPage(AddDateViewModel model) {
    String emptyIconString = 'No ideas yet?';
    return FutureBuilder<String>(
      future: model.randomIdea(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          emptyIconString = 'No ideas yet?\nHow about ${snapshot.data}?';
        }
        return Center(
            child: model.isListValid()
                ? ListView.builder(
                    itemCount: model.getEditorsList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return DateAddIdeaCard(
                          index: index,
                          name: model.getEditorsList()[index],
                          onDelete: model.removeIdea);
                    },
                  )
                : EmptyScreenIcon(emptyIconString,
                    icon: CupertinoIcons.search));
      },
    );
  }

  /// Shows the dialog box to allow the user to enter their ideas.
  Future<void> _showInput(BuildContext context, AddDateViewModel model) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          context,
          controller: model.textController,
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
          icon: Icons.delete, onTap: () => model.removeDialog()),
      CustomDialogButton(context, icon: Icons.add, onTap: () => model.addIdea())
    ];
  }
}
