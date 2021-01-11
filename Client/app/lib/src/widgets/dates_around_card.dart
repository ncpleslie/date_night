import 'dart:ui';
import 'package:model/main.dart';
import 'package:model/models/date_around_model.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeline_tile/timeline_tile.dart';
import '../extensions/string_extensions.dart';

/// The DatesAroundCard Widget is the card that displays dates other
/// other users that are currently happening.
// ignore: must_be_immutable
class DatesAroundCard extends StatelessWidget {
  DatesAroundCard(
      {@required this.date,
      @required this.model,
      this.index,
      this.isFirst = false,
      this.isLast = false}) {
    _chosenDate = date.chosenIdea;

    _otherDates = date.otherIdeas != null || date.otherIdeas.isEmpty
        ? date.otherIdeas.join(', ')
        : null;
  }

  /// Position of the card
  final int index;

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
    return _cardWithWords(context);
  }

  @override
  Widget build2(BuildContext context) {
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
              width: 25,
              height: 25,
              indicator: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      width: 5, color: Theme.of(context).accentColor),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  timeago.format(date.date),
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

  Widget _createPill(BuildContext context) {
    final List<List<Color>> colors = [
      [
        Colors.pink[100],
        Colors.pink[200],
      ],
      [
        Colors.pink[200],
        Colors.pink[300],
      ],
      [
        Colors.pink[300],
        Colors.pink[400],
      ]
    ];
    int colorIndex = index % colors.length;

    final Gradient pillColor = LinearGradient(
        begin: const FractionalOffset(0.0, 0.5),
        end: const FractionalOffset(0.5, 0.0),
        stops: const <double>[0.0, 0.8],
        colors: colors[colorIndex]);

    return Card(
      elevation: Theme.of(context).cardTheme.elevation,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.pink[100],
            gradient: pillColor,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        height: 40,
        child: Text(
          timeago.format(date.date).capitalize(),
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _createOptions(BuildContext context) {
    final double buttonSize = 35;
    return Card(
      elevation: Theme.of(context).cardTheme.elevation,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration:
            BoxDecoration(color: Colors.white12, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: IconButton(
          splashRadius: 21,
          constraints: BoxConstraints(
              maxHeight: buttonSize,
              maxWidth: buttonSize,
              minHeight: buttonSize,
              minWidth: buttonSize),
          padding: EdgeInsets.all(0),
          onPressed: () {},
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black26,
          ),
        ),
      ),
    );
  }

  /// Build the card.
  Widget _cardWithWords(BuildContext context) {
    return Card(
      elevation: Theme.of(context).cardTheme.elevation,
      margin: EdgeInsets.fromLTRB(18, 6, 18, 6),
      shape: Theme.of(context).cardTheme.shape,
      color: Theme.of(context).cardTheme.color,
      shadowColor: Theme.of(context).cardTheme.shadowColor,
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 12),
                  child: _createPill(context),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 12),
                  child: _createOptions(context),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(6, 0, 0, 12),
              child: AutoSizeText(
                _chosenDate.capitalize(),
                softWrap: true,
                maxLines: 2,
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
              child: AutoSizeText(
                'Other Ideas: ${_otherDates.isNotEmpty ? _otherDates : ':('}',
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
                style: Theme.of(context).primaryTextTheme.subtitle1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
