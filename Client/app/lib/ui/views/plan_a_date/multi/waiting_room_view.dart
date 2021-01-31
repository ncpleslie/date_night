import 'package:date_night/ui/views/plan_a_date/multi/plan_a_date_multi_viewmodel.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_app_bar.dart';
import 'package:date_night/ui/widgets/dumb_widgets/page_background.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stacked/stacked.dart';

class WaitingRoomView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WaitingRoomViewState();
}

class _WaitingRoomViewState extends State<WaitingRoomView> {
  bool _ideasChanged = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlanADateMultiViewModel>.reactive(
      viewModelBuilder: () => PlanADateMultiViewModel(),
      builder:
          (BuildContext context, PlanADateMultiViewModel model, Widget child) =>
              Scaffold(
        appBar: CustomAppBar(
          name: 'Room code: ${model.roomId}',
          transparent: false,
        ).build(context),
        body: PageBackground(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: !_ideasChanged
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text('Waiting for your partner to enter their ideas',
                            style: Theme.of(context).textTheme.bodyText2),
                        SizedBox(
                          height: 10,
                        ),
                        LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                        )
                      ])
                : model.isRoomHost
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Your partner has entered their ideas',
                              style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            onPressed: () => {
                              // Navigator.of(context)
                              //     .pushReplacementNamed(Routes.Loading)
                            },
                            child: Text('Continue'),
                          )
                        ],
                      )
                    : Container(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    PlanADateMultiViewModel model = ScopedModel.of(context);

    if (model.roomId == null) {
      // Navigator.of(context).popAndPushNamed(Routes.PlanADateMulti);
    }
    if (model.isRoomHost) {
      _otherUserEntered(model);
    } else {
      _waitForHost(model);
    }
  }

  Future<void> _waitForHost(model) async {
    await model.commitMultiIdeas();
    await model.waitForHost();
    // Navigator.of(context).pushReplacementNamed(Routes.Loading);
  }

  Future<void> _otherUserEntered(PlanADateMultiViewModel model) async {
    await model.commitMultiIdeas();
    await model.ideasHaveChanged((bool stateChanged) => {
          setState(() {
            _ideasChanged = stateChanged;
          })
        });
  }
}
