import 'dart:math';
import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/scoped_model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../widgets/page_background.dart';

class Results extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResultsState();
  }
}

class _ResultsState extends State<Results> with SingleTickerProviderStateMixin {
  final Random _random = Random();
  final List<String> _gifURL = <String>[
    "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
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
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation.addListener(() => setState(() {}));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return PageBackground(child: _results(model));
      },
    );
  }

  Widget _results(MainModel model) {
    return SafeArea(
      top: true,
      bottom: true,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl: _gifURL[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        model.chosenIdea,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        _listOfAltText[_random.nextInt(_listOfAltText.length)],
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40.0 / 2,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20.0),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        color: Theme.of(context).primaryColor,
                        child: const Text(
                          'Let\'s Do This!',
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName(Routes.Index));
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
}
