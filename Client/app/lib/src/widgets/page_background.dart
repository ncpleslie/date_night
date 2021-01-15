import 'dart:ui';

import 'package:date_night/src/config/theme_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// The custom background that will be displayed on most screens.
/// It can be animiated with the background fading between colors.
/// This can be useful to show a "thinking" state to the user and
/// provide feedback that the application is loading.
// ignore: must_be_immutable
class PageBackground extends StatefulWidget {
  PageBackground({@required this.child, this.animated = false});

  /// What will be displayed over the background.
  final Widget child;

  /// If the background will be animated.
  bool animated;

  @override
  State<StatefulWidget> createState() {
    return _PageBackgroundState();
  }
}

class _PageBackgroundState extends State<PageBackground>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    final List<Color> backgroundColors = ThemeConfig.background;
    final Color gradientStart = backgroundColors[2];
    final Color gradientMiddle = backgroundColors[1];
    final Color gradientEnd = backgroundColors[0];

    return Container(
      child: Stack(
        children: [
          SvgPicture.asset(
            ThemeConfig.backgroundImage,
            fit: BoxFit.cover,
          ),
          widget.child,
        ],
      ),
    );

    // return AnimatedBuilder(
    //   animation: _controller,
    //   builder: (BuildContext context, Widget child) {
    //     return Container(
    //       child: widget.child,
    //       decoration: BoxDecoration(
    //         gradient: LinearGradient(
    //             begin: const FractionalOffset(0.0, 0.5),
    //             end: const FractionalOffset(0.5, 0.0),
    //             stops: const <double>[0.0, 0.2, 0.3, 0.7, 0.9],
    //             colors: !widget.animated
    //                 ? <Color>[
    //                     gradientEnd,
    //                     gradientStart,
    //                     gradientStart,
    //                     gradientMiddle,
    //                     gradientEnd,
    //                   ]
    //                 : <Color>[
    //                     _colorTween(gradientStart, gradientEnd),
    //                     _colorTween(gradientEnd, gradientStart),
    //                   ],
    //             tileMode: TileMode.clamp),
    //       ),
    //     );
    //   },
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  /// Creates a tween that can be used when the background is animated.
  Color _colorTween(Color begin, Color end) {
    return ColorTween(begin: begin, end: end).transform(_controller.value);
  }
}
