import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_dialog_button.dart';

/// Dialog box for adding new date ideas on the Add Date page.
class CustomDialog extends StatelessWidget {
  CustomDialog(this.context,
      {this.controller, this.title, this.content, this.dialogButtons});

  final BuildContext context;

  /// The main model
  final TextEditingController controller;
  final String title;
  final Widget content;
  final List<CustomDialogButton> dialogButtons;

  @override
  Widget build(BuildContext context) {
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
            title: Center(
              child: Text(title),
            ),
            content: getContent(),
            actions: dialogButtons,
          ),
        ),
      ),
    );
  }

  Widget getContent() {
    return controller != null
        ? TextField(
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            maxLines: 1,
            controller: controller,
            autofocus: true,
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(filled: true, fillColor: Colors.white),
          )
        : this.content;
  }
}

class RoomCodeDialog extends CustomDialog {
  RoomCodeDialog(BuildContext context,
      {this.controller,
      this.title,
      this.content,
      this.dialogButtons,
      this.onTap})
      : super(context,
            controller: controller,
            title: title,
            content: content,
            dialogButtons: dialogButtons);

  final TextEditingController controller;
  final Function onTap;
  final String title;
  final Widget content;
  final List<CustomDialogButton> dialogButtons;

  @override
  Widget getContent() {
    return TextField(
      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      autofocus: true,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      controller: controller,
      enableInteractiveSelection: true,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
        filled: true,
        fillColor: Colors.white,
        suffix: Container(
          child: Icon(
            Icons.copy,
            color: Colors.black,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
