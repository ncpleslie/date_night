import 'package:date_night/ui/views/plan_a_date/shared/loading/loading_viewmodel.dart';
import 'package:date_night/ui/widgets/dumb_widgets/page_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

/// Displays the loading screen to the user.
/// This creates a buffer screen to allow the client to
/// query the server and provides feedback to the user
/// that the application is processing their request.
class LoadingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoadingViewModel>.reactive(
      viewModelBuilder: () => LoadingViewModel(),
      builder: (BuildContext context, LoadingViewModel model, Widget child) =>
          Scaffold(
        body: PageBackground(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Getting results text
                      Text(
                        '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).primaryTextTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),

              // Animated 'Thinking' heart
              const Positioned(
                  child: Center(
                child: Opacity(
                  opacity: 0.5,
                  child: SpinKitPumpingHeart(
                    size: 300.0,
                    duration: Duration(seconds: 3),
                    color: Colors.white,
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
