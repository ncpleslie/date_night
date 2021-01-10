import 'package:date_night/src/routes/routes.dart';
import 'package:model/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../config/strings.dart';
import '../../widgets/page_background.dart';

/// Displays the winning date idea to the user.
class Results extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResultsState();
  }
}

class _ResultsState extends State<Results> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  ConfettiController _confettiController;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        _confettiController.play();
        return PageBackground(
          child: SafeArea(
            top: true,
            bottom: true,
            child: Material(
              type: MaterialType.transparency,
              child: Transform.scale(
                scale: _animation.value,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        numberOfParticles: 20,
                        maxBlastForce: 30,
                        minBlastForce: 10,
                        shouldLoop: true,
                        colors: const [
                          Colors.green,
                          Colors.blue,
                          Colors.pink,
                          Colors.orange,
                          Colors.purple
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              // Image
                              Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Card(
                                  elevation:
                                      Theme.of(context).cardTheme.elevation,
                                  margin: const EdgeInsets.all(0.0),
                                  shape: Theme.of(context).cardTheme.shape,
                                  clipBehavior: Clip.antiAlias,
                                  child:
                                      // Image.network(
                                      //     model.dateResponse.imageURL,
                                      //     fit: BoxFit.cover)
                                      CachedNetworkImage(
                                    imageUrl: model.isMultiEditing
                                        ? model.dateMultiResponse.imageURL
                                        : model.dateResponse.imageURL,
                                    fit: BoxFit.cover,
                                    errorWidget: (BuildContext context,
                                            String url, dynamic error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                  model.isMultiEditing
                                      ? model.dateMultiResponse.chosenIdea
                                      : model.dateResponse.chosenIdea,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6
                                          .color,
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                  Strings.ResultsResponses[
                                      model.generateRandomInt(
                                          Strings.ResultsResponses.length)],
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6
                                        .color,
                                    fontSize: 40.0 / 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RaisedButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20.0),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  color: Theme.of(context).primaryColor,
                                  child: Text(
                                    'Let\'s Do This!',
                                    style: TextStyle(
                                      fontSize: 40.0,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6
                                          .color,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).popUntil(
                                        ModalRoute.withName(Routes.Index));
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation.addListener(() => setState(() {}));
    _animationController.forward();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
}
