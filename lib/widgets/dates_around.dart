import 'package:flutter/material.dart';

import '../scoped-models/ideas_model.dart';
import './date_card.dart';

class DatesAround extends StatefulWidget {
  final IdeasModel model;
  final dateList;
  DatesAround(this.model, this.dateList);
  @override
  State<StatefulWidget> createState() {
    return _DatesAroundState();
  }
}

class _DatesAroundState extends State<DatesAround> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _buildListView(),
      widget.model.isLoading ? LinearProgressIndicator(backgroundColor: Colors.deepPurple[300], valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple)) : Container()
    ]);
  }

  _buildListView() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return DateCard(index);
      },
      controller: _controller,
      itemCount: widget.model.displayedIdeas.length,
      physics: AlwaysScrollableScrollPhysics(),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        widget.model.fetchDateIdeas();
      });
    }
  }
}
