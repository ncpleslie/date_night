import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_night/src/config/theme_data.dart';
import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/screens/plan_a_date/shared/date_add.dart';
import 'package:date_night/src/widgets/custom_app_bar.dart';
import 'package:date_night/src/widgets/custom_dialog.dart';
import 'package:date_night/src/widgets/custom_dialog_button.dart';
import 'package:date_night/src/widgets/custom_toast.dart';
import 'package:date_night/src/widgets/page_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:model/main.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:scoped_model/scoped_model.dart';

class PlanADateMulti extends StatefulWidget {
  @override
  _PlanADateMultiState createState() => _PlanADateMultiState();
}

class _PlanADateMultiState extends State<PlanADateMulti> {
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
                        _button(
                            title: 'Create a room',
                            subtitle:
                                'Get a room code and share it will another user.\nYou use your phone and they use theirs',
                            onPressed: () => _navigateToMulti(model)),
                        _button(
                            title: 'Enter a room',
                            subtitle:
                                'If your friend has set up a room,\nyou can enter their code and join them',
                            onPressed: () => _enterARoom(context, model)),
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
      height: 175, // Increase this to change the padding
      child: Stack(
        children: <Widget>[
          // Words in card
          Positioned(
            left: 20.0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 175.0,
              child: Card(
                elevation: Theme.of(context).cardTheme.elevation,
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
                        Container(
                          width: 220,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              AutoSizeText(
                                title.toUpperCase(),
                                softWrap: true,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2,
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
                        ),
                        _createChevron(context, onPressed)
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

  Widget _createChevron(BuildContext context, Function onPressed) {
    final double buttonSize = 35;
    return Card(
      elevation: Theme.of(context).cardTheme.elevation,
      child: Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.all(3),
        decoration:
            BoxDecoration(color: Colors.white12, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: InkWell(
          customBorder: new CircleBorder(),
          splashColor: Colors.black26,
          onTap: onPressed,
          onTapDown: (TapDownDetails details) {},
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
                maxHeight: buttonSize,
                maxWidth: buttonSize,
                minHeight: buttonSize,
                minWidth: buttonSize),
            padding: EdgeInsets.all(0),
            child: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.black26,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _enterARoom(BuildContext context, MainModel model) async {
    // Remove stored text when they reopen
    final List<CustomDialogButton> buttons = [
      CustomDialogButton(
        context,
        icon: Icons.chevron_right,
        onTap: () => {
          Navigator.of(context, rootNavigator: true).pop('Continue'),
          _navigateToMulti(model),
          model.isMultiEditing = true,
        },
      )
    ];

    _textController.clear();
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          context,
          controller: _textController,
          title: 'Enter a room code',
          dialogButtons: buttons,
        );
      },
    );
  }

  Future<void> _invalidRoomCode() async {
    final List<CustomDialogButton> buttons = [
      CustomDialogButton(
        context,
        icon: Icons.chevron_right,
        onTap: () => Navigator.of(context, rootNavigator: true).pop('Continue'),
      )
    ];
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          context,
          title: 'Unable to enter that room',
          content: Text('Are you sure that\'s the right room code?'),
          dialogButtons: buttons,
        );
      },
    );
  }

  void _onCopy(BuildContext context, String roomCode) {
    Clipboard.setData(ClipboardData(text: roomCode));
    CustomToast(title: 'Copied!', message: 'Room code copied to clipboard')
        .build(context);
  }

  Future<void> _newRoomCode(String roomCode, MainModel model) async {
    _roomTextController.text = roomCode;

    final List<CustomDialogButton> buttons = [
      CustomDialogButton(
        context,
        icon: Icons.chevron_right,
        onTap: () => {
          pushNewScreen(
            context,
            screen: DateAdd(),
            withNavBar: false,
            pageTransitionAnimation: ThemeConfig.pageTransition,
          ),
          model.isMultiEditing = true,
          model.isRoomHost = true,
          _roomTextController.clear(),
        },
      )
    ];

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return RoomCodeDialog(context,
            controller: _roomTextController,
            title: 'Room Code',
            content: Container(),
            dialogButtons: buttons,
            onTap: () => _onCopy(context, roomCode));
      },
    );
  }

  void _navigateToMulti(MainModel model) async {
    setState(() {
      _isLoading = true;
    });

    if (_textController.text.isNotEmpty) {
      bool isValidRoom = await model.setARoom(_textController.text);
      _textController.text = '';

      if (isValidRoom) {
        Navigator.of(context).pushNamed(Routes.DateAdd);
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
