import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/widgets/custom_app_bar.dart';
import 'package:date_night/src/widgets/page_background.dart';
import 'package:flutter/material.dart';
import 'package:model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class WaitingRoom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WaitingRoomState();
  }
}

class _WaitingRoomState extends State<WaitingRoom> {
  bool _ideasChanged = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget widget, MainModel model) {
      return Scaffold(
        appBar: CustomAppBar(
          name: 'Room code: ${model.roomId}',
          transparent: false,
        ).build(context),
        body: PageBackground(
            child: Container(
          child: !_ideasChanged
              ? Text('Waiting for your partner to enter their ideas')
              : model.isRoomHost
                  ? Column(
                      children: <Widget>[
                        Text(
                            'Some ideas have been added. Want to find out the winning idea?'),
                        RaisedButton(
                          onPressed: () => {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.Loading)
                          },
                          child: Text('And the winner is...'),
                        )
                      ],
                    )
                  : Container(),
        )),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    if (model.isRoomHost) {
      _otherUserEntered(model);
    } else {
      _waitForHost(model);
    }
  }

  Future<void> _waitForHost(model) async {
    await model.commitMultiIdeas();
    await model.waitForHost();
    Navigator.of(context).pushReplacementNamed(Routes.Loading);
  }

  Future<void> _otherUserEntered(MainModel model) async {
    await model.commitMultiIdeas();
    await model.ideasHaveChanged((bool stateChanged) => {
          setState(() {
            _ideasChanged = stateChanged;
          })
        });
  }
}
