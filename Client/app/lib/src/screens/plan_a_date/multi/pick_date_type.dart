import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/widgets/custom_app_bar.dart';
import 'package:date_night/src/widgets/custom_toast.dart';
import 'package:date_night/src/widgets/date_add_dialog_button.dart';
import 'package:date_night/src/widgets/page_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';
import 'package:flushbar/flushbar.dart';

class PickDateType extends StatefulWidget {
  @override
  _PickDateTypeState createState() => _PickDateTypeState();
}

class _PickDateTypeState extends State<PickDateType> {
  bool _isLoading = false;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _roomTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget widget, MainModel model) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            name: '',
            icon: Container(),
          ).build(context),
          body: PageBackground(
            child: Container(
              padding: EdgeInsets.only(top: 70.0),
              alignment: Alignment.center,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : ListView(
                      children: [
                        // _button(
                        //     title: 'Plan a date',
                        //     subtitle:
                        //         'Enter your ideas then hand your phone to someone else',
                        //     onPressed: () => _navigateToSingle(model)),
                        _button(
                            title: 'Create a room',
                            subtitle:
                                'Get a room code and share it will another user.\nYou use your phone and they use theirs',
                            onPressed: () => _navigateToMulti(model)),
                        _button(
                            title: 'Enter a room',
                            subtitle:
                                'If your friend has set up a room,\nyou can enter their code and join them',
                            onPressed: () => _enterARoom(model)),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _button({String title, String subtitle, Function onPressed}) {
    return Container(
      height: 155, // Increase this to change the padding
      child: Stack(
        children: <Widget>[
          // Words in card
          Positioned(
            left: 20.0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 175.0,
              child: Card(
                elevation: 0,
                shape: Theme.of(context).cardTheme.shape,
                color: Theme.of(context).cardTheme.color,
                margin: const EdgeInsets.all(20.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                      primary:
                          Theme.of(context).primaryTextTheme.headline6.color),
                  onPressed: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText(
                              title.toUpperCase(),
                              softWrap: true,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText2,
                            ),
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              height: 1,
                              color: Colors.black38,
                            ),
                            AutoSizeText(
                              subtitle,
                              softWrap: true,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle1
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(width: 30, height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _enterARoom(MainModel model) async {
    // Remove stored text when they reopen
    _textController.text = '';
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          // If the user taps outside form boxes then the keyboard is minimized
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            title: const Center(
              child: Text('Enter a room code'),
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
                  icon: Icons.chevron_right,
                  onTap: () => {
                        Navigator.pop(context),
                        _navigateToMulti(model),
                        model.isMultiEditing = true,
                      })
            ],
          ),
        );
      },
    );
  }

  Future<void> _invalidRoomCode() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          // If the user taps outside form boxes then the keyboard is minimized
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            title: const Center(
              child: Text('Unable to enter that room'),
            ),
            content: Text('Are you sure that\'s the right room code?'),
            actions: <Widget>[
              DateAddDialogButton(
                  icon: Icons.chevron_right,
                  onTap: () => {Navigator.pop(context)})
            ],
          ),
        );
      },
    );
  }

  Future<void> _newRoomCode(String roomCode, MainModel model) async {
    _roomTextController.text = roomCode;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          // If the user taps outside form boxes then the keyboard is minimized
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            title: const Center(
              child: Text('Room code'),
            ),
            content: TextField(
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              autofocus: true,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              controller: _roomTextController,
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
              onTap: () {
                Clipboard.setData(ClipboardData(text: roomCode));
                CustomToast(
                        title: 'Copied!',
                        message: 'Room code copied to clipboard')
                    .build(context);
              },
            ),
            actions: <Widget>[
              DateAddDialogButton(
                  icon: Icons.chevron_right,
                  onTap: () => {
                        Navigator.of(context)
                            .popAndPushNamed(Routes.PlanADateMulti),
                        model.isMultiEditing = true,
                        model.isRoomHost = true
                      })
            ],
          ),
        );
      },
    );
  }

  void _navigateToSingle(MainModel model) {
    model.isMultiEditing = false;
    Navigator.of(context).pushNamed(Routes.PlanADateSingle);
  }

  void _navigateToMulti(MainModel model) async {
    setState(() {
      _isLoading = true;
    });

    if (_textController.text.isNotEmpty) {
      bool isValidRoom = await model.setARoom(_textController.text);
      _textController.text = '';

      if (isValidRoom) {
        Navigator.of(context).pushNamed(Routes.PlanADateMulti);
      } else {
        await _invalidRoomCode();
      }
    } else {
      await model.getARoom();
      await _newRoomCode(model.roomId, model);
    }

    // Give the route change animation time to finish
    Future.delayed(
      const Duration(seconds: 1),
      () => {
        setState(() {
          _isLoading = false;
        })
      },
    );
  }
}
