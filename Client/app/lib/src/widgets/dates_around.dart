import 'package:flutter/material.dart';

import '../scoped_model/ideas_model.dart';
import './date_card.dart';

class DatesAround extends StatefulWidget {
  const DatesAround(this.model, this.dateList);
  final IdeasModel model;
  final Future<List<dynamic>> dateList;

  @override
  State<StatefulWidget> createState() {
    return _DatesAroundState();
  }
}

class _DatesAroundState extends State<DatesAround> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  Widget _buildListView() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return DateCard(index);
      },
      controller: _controller,
      itemCount: widget.model.displayedIdeas.length,
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(
        () {
          widget.model.fetchDateIdeas();
        },
      );
    }
  }
}
