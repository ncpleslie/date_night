import 'package:date_night/ui/views/plan_a_date/multi/plan_a_date_multi_viewmodel.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_app_bar.dart';
import 'package:date_night/ui/widgets/dumb_widgets/page_background.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WaitingRoomView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WaitingRoomViewState();
}

class _WaitingRoomViewState extends State<WaitingRoomView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlanADateMultiViewModel>.reactive(
      viewModelBuilder: () => PlanADateMultiViewModel(),
      onModelReady: (PlanADateMultiViewModel vm) async => init(vm),
      builder: (BuildContext context, PlanADateMultiViewModel vm, Widget child) {
        return WillPopScope(
          onWillPop: vm.onPop,
          child: Scaffold(
            appBar: CustomAppBar(
              name: vm.roomId,
            ).build(context),
            body: PageBackground(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: vm.ideasChanged
                    ? vm.isRoomHost
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Your partner has entered their ideas', style: Theme.of(context).textTheme.bodyText2),
                              SizedBox(
                                height: 10,
                              ),
                              RaisedButton(
                                onPressed: () => vm.navigateToLoading(),
                                child: Text('Continue'),
                              )
                            ],
                          )
                        : Container()
                    : Column(
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
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> init(PlanADateMultiViewModel vm) async {
    await vm.init();
  }
}
