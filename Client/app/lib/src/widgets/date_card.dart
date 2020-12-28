import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/date_around_model.dart';

// ignore: must_be_immutable
class DateCard extends StatelessWidget {
  DateCard({@required this.date}) {
    _chosenDate = date.chosenDate;
    _otherDates = date.otherIdeas != null || date.otherIdeas.isEmpty
        ? date.otherIdeas.join(', ')
        : null;

    _datePosted = DateFormat.EEEE()
        .addPattern('@')
        .add_jm()
        .format(date.datePosted)
        .toString();
    _randomEmoji = _emojis[Random().nextInt(_emojis.length)];
  }

  final List<String> _emojis = <String>[
    ':heart:',
    ':tada:',
    ':heart_eyes:',
    ':champagne:',
    ':beers:'
  ];

  String _chosenDate;
  String _otherDates;
  String _datePosted;
  String _randomEmoji;
  final DateAroundModel date;

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
