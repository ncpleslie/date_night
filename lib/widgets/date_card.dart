import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../scoped-models/ideas_model.dart';

class DateCard extends StatelessWidget {
  final index;
  DateCard(this.index);



  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, IdeasModel model) {

        final _dateData = model.displayedIdeas[index];
        String _otherDates = _dateData.otherIdeas != null
            ? _dateData.otherIdeas.join(', ')
            : null;
        return AbsorbPointer(child:_buildStackOfCards(_dateData, _otherDates, context));
      },
    );
  }

  Widget _buildStackOfCards(dateData, otherDates, context) {
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
              style: TextStyle(fontSize: 90.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _cardWithWords(dateData, otherDates, context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 200.0,
      child: Card(
        color: Colors.deepPurple[300],
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding:
              EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
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
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              otherDates.length != 0
                  ? SizedBox(
                      height: 10.0,
                    )
                  : Container(),
              otherDates.length != 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
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
