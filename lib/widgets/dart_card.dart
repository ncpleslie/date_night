import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final dateIdeas;

  DateCard(this.dateIdeas);

  @override
  Widget build(BuildContext context) {
    String otherDates = dateIdeas.otherDates.join(', ');
    return Card(
      child: SizedBox(
        height: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Winning Idea: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(dateIdeas.chosenDate),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Other Ideas: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(otherDates),
          ],
        ),
      ),
    );
  }
}
