import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/date_ideas.dart';
import '../scoped_model/ideas_model.dart';

class DateCard extends StatelessWidget {
  const DateCard(this.index);
  final int index;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IdeasModel>(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        final DateIdeas _dateData = model.displayedIdeas[index];
        final String _otherDates = _dateData.otherIdeas != null
            ? _dateData.otherIdeas.join(', ')
            : null;

        final Widget content =
            _buildStackOfCards(_dateData, _otherDates, context);
        return content;
      },
    );
  }

  Widget _buildStackOfCards(
      DateIdeas dateData, String otherDates, BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        children: <Widget>[
          // Words in card
          Positioned(
            left: 20.0,
            child: _cardWithWords(dateData, otherDates, context),
          ),
          // Emoji over the top
          Positioned(
            top: 15.0,
            left: 30.0,
            child: Text(
              dateData.randomEmoji,
              style: const TextStyle(fontSize: 90.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _cardWithWords(
      DateIdeas dateData, String otherDates, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 200.0,
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
                    dateData.chosenDate.toString().toUpperCase(),
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              otherDates.isNotEmpty
                  ? const SizedBox(
                      height: 10.0,
                    )
                  : Container(),
              otherDates.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text('💔 '),
                              Text(
                                'Other Ideas: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ]),
                        AutoSizeText(
                          otherDates,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
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
