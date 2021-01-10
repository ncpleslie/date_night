import 'dart:ui';

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
  DatesAroundCard(
      {@required this.date,
      @required this.model,
      this.isFirst = false,
      this.isLast = false}) {
    _chosenDate = date.chosenIdea;

    _otherDates = date.otherIdeas != null || date.otherIdeas.isEmpty
        ? date.otherIdeas.join(', ')
        : null;
  }

  /// If its the first card
  final bool isFirst;

  /// If its the last card
  final bool isLast;

  /// The dates of other users.
  final DateAroundModel date;

  /// The winning date idea.
  String _chosenDate;

  /// The Scoped Model model.
  final MainModel model;

  /// The other date ideas.
  String _otherDates;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125, // Increase this to change the padding
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        height: 125.0,
        width: MediaQuery.of(context).size.width * 0.8,
        child: TimelineTile(
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              drawGap: true,
              color: Colors.white,
              width: 75,
              height: 75,
              indicator: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        width: 5, color: Theme.of(context).accentColor),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 5),
                          blurRadius: 8)
                    ]),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  timeago.format(this.date.date),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
              ),
            ),
            afterLineStyle: LineStyle(color: Colors.white),
            beforeLineStyle: LineStyle(color: Colors.white),
            endChild: _cardWithWords(context)),
      ),
    );
  }

  /// Build the card.
  Widget _cardWithWords(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned(
        top: 60,
        child: Container(
            height: 5,
            width: 12,
            decoration: BoxDecoration(color: Colors.white)),
      ),
      Card(
        elevation: Theme.of(context).cardTheme.elevation,
        margin: EdgeInsets.fromLTRB(12, 6, 18, 6),
        shape: Theme.of(context).cardTheme.shape,
        color: Theme.of(context).cardTheme.color,
        shadowColor: Theme.of(context).cardTheme.shadowColor,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
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
              Container(
                margin: const EdgeInsets.all(8.0),
                height: 1,
                color: Colors.black38,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(EmojiParser().emojify(':broken_heart: ')),
                        Text(
                          'Other Ideas: ',
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                      ]),
                  AutoSizeText(
                    _otherDates.isNotEmpty ? _otherDates : ':(',
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: Theme.of(context).primaryTextTheme.subtitle1,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
