import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Results extends StatelessWidget {
  final String result;
  Results(this.result);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: CupertinoPopupSurface(
        isSurfacePainted: false,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.70,
          width: MediaQuery.of(context).size.width * 0.80,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  result.toUpperCase(),
                  style: TextStyle(fontSize: 86.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Sounds Like A Good Idea To Me',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  softWrap: true,
                ),
                CupertinoDialogAction(
                  child: Text('Woo! Let\'s Do This'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop("Continue");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
