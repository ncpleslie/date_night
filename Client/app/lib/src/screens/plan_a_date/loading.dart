import 'package:date_night/src/scoped_model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../routes/routes.dart';
import '../../widgets/page_background.dart';

/// Displays the loading screen to the user.
/// This creates a buffer screen to allow the client to
/// query the server and provides feedback to the user
/// that the application is processing their request.
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget widget, MainModel model) {
      _getResults(context, model);

      return Scaffold(
          body: PageBackground(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const <Widget>[
                          // Getting results text
                          Text(
                            'Calculating...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Animated 'Thinking' bubble
                  const Positioned(
                      child: Center(
                    child: Opacity(
                      opacity: 0.5,
                      child: SpinKitDoubleBounce(
                        size: 300.0,
                        duration: Duration(seconds: 3),
                        color: Colors.white,
                      ),
                    ),
                  )),
                ],
              ),
              animated: true));
    });
  }

  /// Calculates the results of their users chosen request.
  /// These results can be grabbed from the model when needed.
  /// (Probably the results page).
  Future<void> _getResults(BuildContext context, MainModel model) async {
    await model.calculateResults();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(Routes.Results);
    });
  }
}
