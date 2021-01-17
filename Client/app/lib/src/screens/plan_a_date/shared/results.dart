import 'package:auto_size_text/auto_size_text.dart';
import 'package:confetti/confetti.dart';
import 'package:date_night/src/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:model/main.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../config/strings.dart';
import '../../../widgets/page_background.dart';

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
                    ConfettiCanon(confettiController: _confettiController),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ResultsCard(),
                          ContinueButton(),
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

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            shape: Theme.of(context).cardTheme.shape,
            color: Theme.of(context).primaryColor,
            child: FaIcon(FontAwesomeIcons.chevronRight),
            onPressed: () {
              Navigator.of(context).popUntil(ModalRoute.withName(Routes.Index));
            },
          )
        ],
      ),
    );
  }
}

class ResultsCard extends StatelessWidget {
  const ResultsCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Card(
          elevation: Theme.of(context).cardTheme.elevation,
          margin: EdgeInsets.fromLTRB(18, 6, 18, 6),
          shape: Theme.of(context).cardTheme.shape,
          color: Theme.of(context).cardTheme.color,
          shadowColor: Theme.of(context).cardTheme.shadowColor,
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(6, 0, 0, 12),
                  child: AutoSizeText(
                    model.isMultiEditing
                        ? model.dateMultiResponse.chosenIdea
                        : model.dateResponse.chosenIdea,
                    softWrap: true,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline5
                        .copyWith(fontSize: 60),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                  child: AutoSizeText(
                    Strings.ResultsResponses[model
                        .generateRandomInt(Strings.ResultsResponses.length)],
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.headline6,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ConfettiCanon extends StatelessWidget {
  const ConfettiCanon({
    Key key,
    @required ConfettiController confettiController,
  })  : _confettiController = confettiController,
        super(key: key);

  final ConfettiController _confettiController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirectionality: BlastDirectionality.explosive,
        numberOfParticles: 30,
        maxBlastForce: 10,
        minBlastForce: 5,
        shouldLoop: true,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ],
      ),
    );
  }
}
