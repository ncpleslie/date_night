import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_night/src/config/theme_data.dart';
import 'package:model/main.dart';
import 'package:model/models/date_around_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeline_tile/timeline_tile.dart';

/// The DatesAroundCard Widget is the card that displays dates other
/// other users that are currently happening.
// ignore: must_be_immutable
class DatesAroundCard extends StatelessWidget {
  DatesAroundCard({@required this.date, @required this.model}) {
    _chosenDate = date.chosenIdea;

    _datePosted =
        DateFormat.EEEE().addPattern('@').add_jm().format(date.date).toString();

    _otherDates = date.otherIdeas != null || date.otherIdeas.isEmpty
        ? date.otherIdeas.join(', ')
        : null;

    _randomEmoji = _emojis[model.generateRandomInt(_emojis.length)];
  }

  /// The dates of other users.
  final DateAroundModel date;

  /// The winning date idea.
  String _chosenDate;

  /// When the date was posted.
  String _datePosted;

  /// Possible emojis that can be displayed over the date card
  final List<String> _emojis = <String>[
    ':heart:',
    ':tada:',
    ':heart_eyes:',
    ':champagne:',
    ':beers:'
  ];

  /// The Scoped Model model.
  final MainModel model;

  /// The other date ideas.
  String _otherDates;

  /// The emoji that will be displayed over the card.
  String _randomEmoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155, // Increase this to change the padding
      child: Stack(
        children: <Widget>[
          // Words in card
          Positioned(
            left: 20.0,
            child: _cardWithWords(context),
          ),
          Positioned(
              left: 20.0,
              child: Container(
                  height: 175.0,
                  width: 150,
                  child: TimelineTile(
                    indicatorStyle: IndicatorStyle(
                      color: Colors.white,
                      width: 75,
                      height: 75,
                      indicator: Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(12.5),
                        color: Theme.of(context).accentColor,
                        child: Text(
                          timeago.format(this.date.date),
                          style: Theme.of(context).primaryTextTheme.subtitle1,
                        ),
                      ),
                    ),
                    afterLineStyle: LineStyle(color: Colors.white),
                    beforeLineStyle: LineStyle(color: Colors.white),
                  ))
              // Text(
              //   EmojiParser().emojify(_randomEmoji),
              //   style: const TextStyle(fontSize: 90.0),
              // ),
              )
        ],
      ),
    );
  }

  // Widget _cardWithWords2(BuildContext context) {
  //   return Card(
  //     elevation: 0,
  //     margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
  //     child: Container(
  //       decoration: BoxDecoration(color: Theme.of(context).cardColor),
  //       child: Stack(
  //         children: <Widget>[_buildPodcastTile(), _buildImage()],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildImage() {
  //   return Container(
  //     height: 70.0,
  //     width: 70.0,
  //     child: Text(
  //       EmojiParser().emojify(_randomEmoji),
  //       style: const TextStyle(fontSize: 90.0),
  //     ),
  //   );
  // }

  /// Build the card.
  Widget _cardWithWords(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 175.0,
      child: Card(
        shape: Theme.of(context).cardTheme.shape,
        color: Theme.of(context).cardTheme.color,
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 100.0, right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(_chosenDate.toString().toUpperCase(),
                      softWrap: true,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).primaryTextTheme.bodyText1),
                ],
              ),
              _otherDates.isNotEmpty
                  ? const SizedBox(
                      height: 10.0,
                    )
                  : Container(),
              _otherDates.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(EmojiParser().emojify(':broken_heart: ')),
                              Text(
                                'Other Ideas: ',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                              ),
                            ]),
                        AutoSizeText(
                          _otherDates,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: Theme.of(context).primaryTextTheme.subtitle1,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
