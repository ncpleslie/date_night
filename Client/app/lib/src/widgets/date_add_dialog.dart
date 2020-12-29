import 'package:model/main.dart';
import 'package:date_night/src/widgets/date_add_dialog_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Dialog box for adding new date ideas on the Add Date page.
class DateAddDialog extends StatelessWidget {
  DateAddDialog({@required this.model});

  /// The main model
  final MainModel model;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // If the user taps outside form boxes then the keyboard is minimized
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        title: const Center(
          child: Text('Date Ideas?'),
        ),
        content: TextField(
          textCapitalization: TextCapitalization.sentences,
          autocorrect: true,
          maxLines: 1,
          controller: _textController,
          autofocus: true,
        ),
        actions: <Widget>[
          DateAddDialogButton(
              icon: Icons.delete, onTap: () => _discard(context)),
          DateAddDialogButton(icon: Icons.add, onTap: () => _addIdea(context))
        ],
      ),
    );
  }

  /// Add the idea to list of possible dates
  void _addIdea(BuildContext context) {
    if (_textController.text.isNotEmpty) {
      model.addIdea(_textController.text);

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
