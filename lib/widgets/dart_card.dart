import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final dateIdeas;

  DateCard(this.dateIdeas);

  @override
  Widget build(BuildContext context) {
    String otherDates = dateIdeas.otherDates.join(', ');
    return Card(
      margin: EdgeInsets.all(10.0),
      child: SizedBox(
        height: 70.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
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
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
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
            ),
          ],
        ),
      ),
    );
  }
}
