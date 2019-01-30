import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../secondary-pages/results.dart';

class LoadingPage extends StatelessWidget {
  final String winningDate;
  LoadingPage(this.winningDate);

  @override
  Widget build(BuildContext context) {
    return _buildPage(context, winningDate);
  }

  Widget _buildPage(context, winningDate) {
    Future.delayed(Duration(seconds: 3), () {
      _showResults(context, winningDate);
    });
    return Scaffold(body: _buildBackgroundWithBody());
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
                  'CALCULATING...',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Hopefully, no one gets angry',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          child: Opacity(
            opacity: 0.5,
            child: SpinKitDoubleBounce(
              size: 200.0,
              duration: Duration(seconds: 3),
              color: Colors.white,
            ),
          ),
        ),
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

  Future<Null> _showResults(context, winningDate) async {
    Navigator.of(context).pushReplacementNamed('/');
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            widthFactor: MediaQuery.of(context).size.width * 0.90,
            heightFactor: MediaQuery.of(context).size.height * 0.90,
            child: Results(winningDate),
          );
        });
  }
}
