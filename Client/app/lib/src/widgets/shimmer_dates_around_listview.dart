import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A Shimmer version of the DatesAround card.
/// Will display while loading
// ignore: must_be_immutable
class ShimmerDatesAroundListView extends StatelessWidget {
  int offset = 0;
  int time = 1500;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      itemCount: 4,
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
    return Container(
      height: 155, // Increase this to change the padding
      child: Stack(
        children: <Widget>[
          // Words in card
          Positioned(
            left: 20.0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 175.0,
              child: Card(
                color: Theme.of(context).cardTheme.color,
                shape: Theme.of(context).cardTheme.shape,
                margin: const EdgeInsets.all(20.0),
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                    child: Container()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
