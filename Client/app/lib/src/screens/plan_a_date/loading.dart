import 'package:date_night/src/scoped_model/ideas_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../routes/routes.dart';
import '../../widgets/page_background.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IdeasModel>(
        builder: (BuildContext context, Widget widget, IdeasModel model) {
      _getResults(context, model);

      return Scaffold(
          body: PageBackground(child: _buildLoadingPage(), animated: true));
    });
  }

  Future<void> _getResults(BuildContext context, IdeasModel model) async {
    await model.calculateResults();
    Navigator.of(context).pushReplacementNamed(Routes.Results);
  }

  Widget _buildLoadingPage() {
    return Stack(
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
    );
  }
}
