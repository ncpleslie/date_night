import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "dart:math";

import 'package:giffy_dialog/giffy_dialog.dart';

class Results extends StatelessWidget {
  final String result;
  Results(this.result);
  final _random = new Random();
  final List<String> _gifURL =["https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif", "https://raw.githubusercontent.com/xsahil03x/giffy_dialog/master/example/assets/men_wearing_jacket.gif"];

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: NetworkGiffyDialog(
          imageUrl: _gifURL[_random.nextInt(_gifURL.length)],
          title: Text(result.toUpperCase(),
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w600)),
          description: Text('Sounds Good To Me'),
          onOkButtonPressed: () {
            Navigator.of(context, rootNavigator: true).pop("Continue");
          },
        )

        /* CupertinoPopupSurface(
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
      ),*/
        );
  }
}
