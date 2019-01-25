import 'package:flutter/material.dart';
import "dart:math";

class DateCard extends StatelessWidget {
  final dateIdeas;

  DateCard(this.dateIdeas);

  @override
  Widget build(BuildContext context) {
    final random = new Random();
    final List<String> _emojiList = ['🎉', '😍', '🍾', '🍻'];

    String _otherDates =
        dateIdeas.otherDates != null ? dateIdeas.otherDates.join(', ') : null;
    return Container(
        height: 200,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 20.0,
              child: _cardWithWords(_otherDates, context),
            ),
            Positioned(
              top: 15.0,
              left: 30.0,
              child: Text(
                _emojiList[random.nextInt(_emojiList.length)],
                style: TextStyle(fontSize: 90.0),
              ),
            )
          ],
        ));
  }

  Widget _cardWithWords(otherDates, context) {
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
                  Text(
                    dateIdeas.chosenDate.toUpperCase(),
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              otherDates != null
                  ? SizedBox(
                      height: 10.0,
                    )
                  : Container(),
              otherDates != null
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
                        Text(
                          otherDates,
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
