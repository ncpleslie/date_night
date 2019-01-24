import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Results extends StatelessWidget {
  final String result;
  Results(this.result);

  @override
  Widget build(BuildContext context) {
    return 
    Opacity(
      opacity: 0.85,
      child: CupertinoAlertDialog(
        content: Container(
          height: MediaQuery.of(context).size.height * 0.50,
          width: MediaQuery.of(context).size.width * 0.70,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  result.toUpperCase(),
                  style: TextStyle(fontSize: 86.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text('Sounds Like A Good Idea To Me',
                    style: TextStyle(fontSize: 24.0))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
