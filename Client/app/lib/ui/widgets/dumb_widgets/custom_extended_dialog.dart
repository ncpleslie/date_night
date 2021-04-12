import 'dart:ui';

import 'package:date_night/app/locator.dart';
import 'package:date_night/enums/dialog_response_type.dart';
import 'package:date_night/models/dialog_response_model.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_dialog_button.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:date_night/enums/dialog_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  var dialogService = locator<DialogService>();

  final builders = {
    DialogType.Basic: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
    DialogType.Form: (context, sheetRequest, completer) =>
        _FormDialog(request: sheetRequest, completer: completer),
    DialogType.FormWithText: (context, sheetRequest, completer) =>
        _FormWithTextDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _BasicDialog({Key key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              request.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              request.description,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => completer(DialogResponse(confirmed: true)),
              child: Container(
                child: request.showIconInMainButton
                    ? Icon(Icons.check_circle)
                    : Text(request.mainButtonTitle),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FormDialog extends HookWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _FormDialog({Key key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = useTextEditingController();
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: AlertDialog(
          backgroundColor: Theme.of(context).cardTheme.color,
          shape: Theme.of(context).dialogTheme.shape,
          title: Center(
            child: Text(request.title),
          ),
          content: getContent(controller),
          actions: <Widget>[
            CustomDialogButton(context,
                icon: Icons.chevron_right,
                onTap: () => completer(DialogResponse(
                    confirmed: true, responseData: CustomDialogResponse(type: DialogResponseType.Text, response: controller.text))))
          ],
        ),
      ),
    );
  }

  Widget getContent(TextEditingController controller) {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      autocorrect: true,
      maxLines: 1,
      controller: controller,
      autofocus: true,
      style: TextStyle(fontSize: 20.0),
      decoration: InputDecoration(filled: true, fillColor: Colors.white),
    );
  }
}

class _FormWithTextDialog extends _FormDialog {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _FormWithTextDialog({Key key, this.request, this.completer})
      : super(key: key);

  @override
  Widget getContent(TextEditingController controller) {
    controller.text = request.description;
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
      onTap: () => completer(DialogResponse(
          confirmed: false,
          responseData: CustomDialogResponse(type: DialogResponseType.Copied))),
    );
  }
}
