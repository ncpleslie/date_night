import 'package:date_night/ui/views/plan_a_date/multi/plan_a_date_multi_viewmodel.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_app_bar.dart';
import 'package:date_night/ui/widgets/dumb_widgets/page_background.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:date_night/extensions/string_extensions.dart';

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
          child: SafeArea(
            bottom: true,
            top: true,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: CustomAppBar(
                name: vm.roomId,
                transparent: true,
              ).build(context),
              body: PageBackground(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: vm.ideasChanged
                      ? vm.isRoomHost
                          ? _getIdeasEnteredWidget(vm)
                          : Container()
                      : _getWaitingForIdeasWidget(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getIdeasEnteredWidget(PlanADateMultiViewModel vm) {
    String totalContributorsSoFar = vm.totalContributors;
    String text = totalContributorsSoFar == 'one' 
    ? 'A partner has entered their ideas' 
    : '${totalContributorsSoFar.capitalize()} partners have entered their ideas';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text, style: Theme.of(context).textTheme.bodyText2),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(Theme.of(context).cardTheme.shape),
              padding:
                  MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0)),
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).buttonColor),
              foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColorDark)),
          onPressed: () => vm.navigateToLoading(),
          child: Text('Continue'),
        )
      ],
    );
  }

  Widget _getWaitingForIdeasWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Waiting for your partner to enter their ideas', style: Theme.of(context).textTheme.bodyText2),
        SizedBox(
          height: 10,
        ),
        LinearProgressIndicator(
          backgroundColor: Colors.transparent,
        )
      ],
    );
  }

  Future<void> init(PlanADateMultiViewModel vm) async {
    await vm.init();
  }
}
