import 'package:flutter/material.dart';

class DatesAround extends StatefulWidget {
  final Color color;

  DatesAround(this.color);

  @override
    State<StatefulWidget> createState() {
      return _DatesAroundState();
    }
}

class _DatesAroundState extends State<DatesAround> {
  @override
    Widget build(BuildContext context) {
      return Container(color: widget.color);
    }
}