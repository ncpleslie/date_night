import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final dateIdeas;

  DateCard(this.dateIdeas);

 @override
   Widget build(BuildContext context) {
     print(dateIdeas.id);
     print(dateIdeas.chosenDate);
     print(dateIdeas.otherDates);
     return Card(
       child: Column(children: <Widget>[
         
       //  Text(dateIdeas.chosenDate),
        // Text(dateIdeas.otherIdeas)
       ],),
     );
   }
}

