import 'dart:ui';

import 'package:date_night/ui/widgets/dumb_widgets/custom_dialog_button.dart';
import 'package:date_night/ui/widgets/smart_widgets/date_add_dialog/date_add_dialog_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';


/// Dialog box for adding new date ideas on the Add Date page.
// ignore: must_be_immutable
class DateAddDialog extends StatelessWidget {
  DateAddDialog(this.context);

  final BuildContext context;

  DateAddDialogViewModel _model;

  /// The main model
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DateAddDialogViewModel>.nonReactive(
      viewModelBuilder: () => DateAddDialogViewModel(),
      builder:
          (BuildContext context, DateAddDialogViewModel model, Widget child) {
        if (_model == null) _model = model;
        return GestureDetector(
          // If the user taps outside form boxes then the keyboard is minimized
          onTap: () {
            FocusScope.of(this.context).requestFocus(FocusNode());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: AlertDialog(
                backgroundColor: Theme.of(this.context).cardTheme.color,
                shape: Theme.of(this.context).dialogTheme.shape,
                title: const Center(
                  child: Text('Date Ideas?'),
                ),
                content: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  maxLines: 1,
                  controller: _textController,
                  autofocus: true,
                  style: TextStyle(fontSize: 20.0),
                  decoration:
                      InputDecoration(filled: true, fillColor: Colors.white),
                ),
                actions: <Widget>[
                  CustomDialogButton(this.context,
                      icon: Icons.delete, onTap: () => _discard(this.context)),
                  CustomDialogButton(this.context,
                      icon: Icons.add, onTap: () => _addIdea(this.context))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Add the idea to list of possible dates
  void _addIdea(BuildContext context) {
    if (_textController.text.isNotEmpty) {
      _model.addIdea(_textController.text);
      // if (model.isMultiEditing) {
      //   model.addMultiIdea(_textController.text);
      // } else {
      //   model.addIdea(_textController.text);
      // }

      // Clear text from dialog.
      // Otherwise text will remain next time.
      _textController.text = '';

      // Remove the dialog box.
      Navigator.of(context, rootNavigator: true).pop('Continue');
    }
  }

  /// Discard the date and remove the dialog box
  void _discard(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop('Discard');
  }
}
