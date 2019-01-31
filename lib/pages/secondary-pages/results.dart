import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';

class Results extends StatefulWidget {
  const Results(this.result);
  final String result;

  @override
  State<StatefulWidget> createState() {
    return _ResultsState();
  }
}

class _ResultsState extends State<Results> with SingleTickerProviderStateMixin {
  final Random _random = Random();
  final List<String> _gifURL = <String>[
    'https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF\'s/gif14.gif',
    'https://raw.githubusercontent.com/xsahil03x/giffy_dialog/master/example/assets/men_wearing_jacket.gif'
  ];
  final List<String> _listOfAltText = <String>[
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
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation.addListener(() => setState(() {}));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBackgroundWithBody();
  }

  Widget _buildResults() {
    final double _fontSizeBasedOnTextLength =
        widget.result.length >= 9 ? 40.0 : 50.0;
    return SafeArea(
      bottom: true,
      top: false,
      child: Material(
        type: MaterialType.transparency,
        child: Transform.scale(
          scale: _animation.value,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // Image
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Card(
                        elevation: 0,
                        margin: const EdgeInsets.all(0.0),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0))),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl: _gifURL[_random.nextInt(_gifURL.length)],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        widget.result.toUpperCase(),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _fontSizeBasedOnTextLength,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        _listOfAltText[_random.nextInt(_listOfAltText.length)],
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _fontSizeBasedOnTextLength / 2,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20.0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Let\'s Do This!',
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/'));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundWithBody() {
    Color gradientStart = Colors.deepPurple[700];
    Color gradientEnd = Colors.purple[500];
    return Container(
      child: _buildResults(),
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
}

/*   NetworkGiffyDialog(
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
        ), */
