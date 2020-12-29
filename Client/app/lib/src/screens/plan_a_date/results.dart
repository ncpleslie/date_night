import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/scoped_model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../config/images.dart';
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

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return PageBackground(
          child: SafeArea(
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
                                imageUrl: Images.ResultsImagesURL[
                                    model.generateRandomInt(
                                        Images.ResultsImagesURL.length)],
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
                              Strings.ResultsResponses[model.generateRandomInt(
                                  Strings.ResultsResponses.length)],
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
  }
}
