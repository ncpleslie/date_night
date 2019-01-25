import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final dateIdeas;

  DateCard(this.dateIdeas);

  @override
  Widget build(BuildContext context) {
    String otherDates =
        dateIdeas.otherDates != null ? dateIdeas.otherDates.join(', ') : null;
    return Card(
      margin: EdgeInsets.all(20.0),
      child: SizedBox(
        height: 70.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 10.0),
                Text('🎉 '),
                Text(
                  'Winning Idea: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(
                    child: Text(
                  dateIdeas.chosenDate,
                  softWrap: true,
                  maxLines: 2,
                )),
              ],
            ),
            otherDates != null
                ? SizedBox(
                    height: 10.0,
                  )
                : Container(),
            otherDates != null
                ? Row(
                    children: <Widget>[
                      SizedBox(width: 10.0),
                      Text('💔 '),
                      Text(
                        'Other Ideas: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                          child: Text(
                        otherDates,
                        softWrap: true,
                        maxLines: 1,
                      )),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
