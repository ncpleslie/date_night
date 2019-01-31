import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../secondary-pages/results.dart';

class LoadingPage extends StatefulWidget {
  final String winningDate;
  LoadingPage(this.winningDate);

  @override
  State<StatefulWidget> createState() {
    return _LoadingPageState();
  }
}

class _LoadingPageState extends State<LoadingPage> {
  int loopPrevent = 0;
  String displayedText = 'CALCULATING...';
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return _buildPage(context, widget.winningDate);
  }

  Widget _buildPage(context, winningDate) {
    if (loopPrevent == 0) {
      Future.delayed(Duration(seconds: 3), () {
        _showResults(context, winningDate);
        if (mounted) {
          Future.delayed(Duration(seconds: 3), () {
            displayedText = 'Error Loading';
            error = true;
            setState(() {});
          });
        }
      });

      loopPrevent++;
    }
    return Material(child: _buildBackgroundWithBody());
  }

  Widget _buildLoadingPage() {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  displayedText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          child: Opacity(
            opacity: 0.5,
            child: SpinKitDoubleBounce(
              size: 250.0,
              duration: Duration(seconds: 3),
              color: Colors.white,
            ),
          ),
        ),
        error
            ? Positioned(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    child: Text('Go Back'),
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/'),
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  Widget _buildBackgroundWithBody() {
    Color gradientStart = Colors.deepPurple[700];
    Color gradientEnd = Colors.purple[500];
    return Container(
      child: _buildLoadingPage(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.5),
            end: FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            colors: [gradientStart, gradientEnd],
            tileMode: TileMode.clamp),
      ),
    );
  }

  void _showResults(BuildContext context, winningDate) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Results(winningDate);
      },
    );
  }
  
  @override
  void dispose() {
    super.dispose();
  }
}
