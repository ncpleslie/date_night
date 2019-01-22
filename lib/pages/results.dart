import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  final String result;
  Results(this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(result),
            ],
          ),
        ),
      ),
    );
  }
}
