import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/widgets/custom_app_bar.dart';
import 'package:date_night/src/widgets/date_add_dialog_button.dart';
import 'package:date_night/src/widgets/page_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class PickDateType extends StatefulWidget {
  @override
  _PickDateTypeState createState() => _PickDateTypeState();
}

class _PickDateTypeState extends State<PickDateType> {
  bool _isLoading = false;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget widget, MainModel model) {
        return Scaffold(
          appBar: CustomAppBar(
            name: 'Plan A Date',
            icon: Container(),
          ).build(context),
          body: PageBackground(
            child: Container(
              alignment: Alignment.center,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : ListView(
                      children: [
                        _button(
                            title: 'Plan a date with this phone',
                            onPressed: _navigateToSingle),
                        _button(
                            title:
                                'Plan a date with this phone\nand another phone',
                            onPressed: () => _navigateToMulti(model)),
                        _button(
                            title: 'Enter a room code',
                            onPressed: () => _enterARoom(model)),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _button({String title, Function onPressed}) {
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
                elevation: 10,
                color: Colors.deepPurple[300],
                margin: const EdgeInsets.all(20.0),
                child: TextButton(
                  style: TextButton.styleFrom(primary: Colors.black),
                  onPressed: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText(
                              title,
                              softWrap: true,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
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
                  onTap: () =>
                      {Navigator.pop(context), _navigateToMulti(model)})
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

  void _navigateToSingle() {
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
      Navigator.of(context).pushNamed(Routes.PlanADateMulti);
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
