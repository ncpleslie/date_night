import 'package:date_night/src/scoped_model/main_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/date_around_model.dart';

/// The DateCard Widget is the card that displays dates other
/// other users that are currently happening.
// ignore: must_be_immutable
class DateCard extends StatelessWidget {
  DateCard({@required this.date, @required this.model}) {
    _chosenDate = date.chosenDate;

    _datePosted = DateFormat.EEEE()
        .addPattern('@')
        .add_jm()
        .format(date.datePosted)
        .toString();

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
      height: 150, // Increase this to change the padding
      child: Stack(
        children: <Widget>[
          // Words in card
          Positioned(
            left: 20.0,
            child: _cardWithWords(context),
          ),
          // Emoji over the top
          Positioned(
            top: 5.0,
            left: 20.0,
            child: Text(
              EmojiParser().emojify(_randomEmoji),
              style: const TextStyle(fontSize: 90.0),
            ),
          )
        ],
      ),
    );
  }

  /// Build the card.
  Widget _cardWithWords(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 175.0,
      child: Card(
        color: Colors.deepPurple[300],
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    _chosenDate.toString().toUpperCase(),
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
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
                              const Text(
                                'Other Ideas: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ]),
                        AutoSizeText(
                          _otherDates,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ],
                    )
                  : Container(),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(_datePosted)
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
