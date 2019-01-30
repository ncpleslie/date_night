import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import "dart:math";

import 'package:giffy_dialog/giffy_dialog.dart';

class Results extends StatefulWidget {
  final String result;
  Results(this.result);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ResultsState();
  }
}

class _ResultsState extends State<Results> with SingleTickerProviderStateMixin {
  final _random = Random();
  final List<String> _gifURL = [
    "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
    "https://raw.githubusercontent.com/xsahil03x/giffy_dialog/master/example/assets/men_wearing_jacket.gif"
  ];
  final List<String> _listOfAltText = [
    'Sounds Good To Me',
    'Excellent Idea',
    'Great Thinking, Team!',
    'Ooooooh Yeah! I Love How You Think'
  ];
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.linear);
    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double _fontSizeBasedOnTextLength =
        widget.result.length >= 9 ? 40.0 : 50.0;
    return Material(
      type: MaterialType.transparency,
      child: Transform.scale(
        scale: _animation.value,
        child: NetworkGiffyDialog(
          imageUrl: _gifURL[_random.nextInt(_gifURL.length)],
          title: Text(
            widget.result.toUpperCase(),
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
                color: Colors.white,
                fontSize: _fontSizeBasedOnTextLength,
                fontWeight: FontWeight.w600),
          ),
          description: Text(
            _listOfAltText[_random.nextInt(_listOfAltText.length)],
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: _fontSizeBasedOnTextLength / 2,
            ),
          ),
          buttonOkColor: Theme.of(context).primaryColor,
          buttonOkText: Text(
            'Go Do It',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onOkButtonPressed: () =>
              Navigator.of(context, rootNavigator: true).pop('Continue'),
        ),
      ),
    );
  }
}
