import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DatesAround extends StatefulWidget {

  @override
    State<StatefulWidget> createState() {
      return _DatesAroundState();
    }
}

class _DatesAroundState extends State<DatesAround> {
  @override
    Widget build(BuildContext context) {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Dates Around You'),
            )
          ],
        ),
      );
    }
}