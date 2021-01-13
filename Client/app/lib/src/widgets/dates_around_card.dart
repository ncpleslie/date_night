import 'dart:ui';
import 'dart:core';
import 'package:date_night/src/widgets/custom_toast.dart';
import 'package:model/main.dart';
import 'package:model/models/date_around_model.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../extensions/string_extensions.dart';

/// The DatesAroundCard Widget is the card that displays dates other
/// other users that are currently happening.
// ignore: must_be_immutable
class DatesAroundCard extends StatelessWidget {
  DatesAroundCard(
      {@required this.id,
      @required this.date,
      @required this.model,
      this.index}) {
    _chosenDate = date.chosenIdea;

    _otherDates = date.otherIdeas != null || date.otherIdeas.isEmpty
        ? date.otherIdeas.join(', ')
        : null;
  }

  final List<List<Color>> pillColors = [
    [
      Colors.white70,
      Colors.white,
    ],
  ];

  /// Card and inputs id.
  final String id;

  /// Position of the card.
  final int index;

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

  Widget _createPill(BuildContext context) {
    int colorIndex = index % pillColors.length;

    final Gradient pillColor = LinearGradient(
        begin: const FractionalOffset(0.0, 0.5),
        end: const FractionalOffset(0.5, 0.0),
        stops: const <double>[0.0, 0.8],
        colors: pillColors[colorIndex]);

    return Card(
      elevation: Theme.of(context).cardTheme.elevation,
      child: Container(
        decoration: BoxDecoration(
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
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
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
        child: InkWell(
          customBorder: new CircleBorder(),
          splashColor: Colors.black26,
          onTap: () {},
          onTapDown: (TapDownDetails details) {
            _optionsPopupMenu(context, details.globalPosition);
          },
          child: Container(
            constraints: BoxConstraints(
                maxHeight: buttonSize,
                maxWidth: buttonSize,
                minHeight: buttonSize,
                minWidth: buttonSize),
            padding: EdgeInsets.all(0),
            child: Icon(
              Icons.more_horiz,
              color: Colors.black26,
            ),
          ),
        ),
      ),
    );
  }

  void _optionsPopupMenu(BuildContext context, Offset offset) async {
    int result = await showMenu(
      shape: Theme.of(context).cardTheme.shape,
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem<int>(
          value: 0,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Report',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
      elevation: 8.0,
    );
    if (result == 0) {
      model.reportDate(id);
      CustomToast(
        title: "Reported",
        message: "Thank you. This date has been reported",
      ).build(context);
    }
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Other Ideas: ',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.bold)),
                  AutoSizeText(
                    _otherDates.isNotEmpty ? _otherDates : ':(',
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: Theme.of(context).primaryTextTheme.subtitle1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
