import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        offset += 10;
        time = time + offset;
        return Shimmer.fromColors(
            highlightColor: Theme.of(context).primaryColor,
            baseColor: Theme.of(context).accentColor,
            period: Duration(milliseconds: time),
            child: _card(context, index == 0, index == itemCount - 1));
      },
    );
  }

  /// Build the card.
  Widget _card(BuildContext context, bool isFirst, bool isLast) {
    return Container(
      height: 125, // Increase this to change the padding
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        height: 125.0,
        width: MediaQuery.of(context).size.width * 0.8,
        child: TimelineTile(
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              drawGap: true,
              width: 75,
              height: 75,
              indicator: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          width: 5, color: Theme.of(context).accentColor),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            offset: Offset(0, 5),
                            blurRadius: 8)
                      ]),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container()),
            ),
            endChild: _cardWithWords(context)),
      ),
    );
  }
}

Widget _cardWithWords(BuildContext context) {
  return Stack(children: <Widget>[
    Positioned(
      top: 60,
      child: Container(
          height: 5, width: 12, decoration: BoxDecoration(color: Colors.white)),
    ),
    Card(
        elevation: 0,
        margin: EdgeInsets.fromLTRB(12, 6, 18, 6),
        shape: Theme.of(context).cardTheme.shape,
        color: Theme.of(context).cardTheme.color,
        child: Container()),
  ]);
}
