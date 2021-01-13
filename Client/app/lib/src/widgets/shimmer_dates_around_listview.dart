import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A Shimmer version of the DatesAround card.
/// Will display while loading
// ignore: must_be_immutable
class ShimmerDatesAroundListView extends StatelessWidget {
  int offset = 0;
  int time = 1500;
  final int itemCount = 6;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        offset += 10;
        time = time + offset;
        return Shimmer.fromColors(
            highlightColor: Theme.of(context).primaryColor,
            baseColor: Theme.of(context).accentColor,
            period: Duration(milliseconds: time),
            child: _card(context));
      },
    );
  }

  /// Build the card.
  Widget _card(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.fromLTRB(18, 6, 18, 6),
      shape: Theme.of(context).cardTheme.shape,
      color: Theme.of(context).cardTheme.color,
      shadowColor: Theme.of(context).cardTheme.shadowColor,
      child: Container(
        height: 160,
      ),
    );
  }
}
