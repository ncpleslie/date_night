import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class PageBackground extends StatefulWidget {
  PageBackground({this.child, this.animated = false});

  final Widget child;
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
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final Color gradientStart = Colors.deepPurple[700];
    final Color gradientEnd = Colors.purple[500];
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Container(
          child: widget.child,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: const FractionalOffset(0.0, 0.5),
                end: const FractionalOffset(0.5, 0.0),
                stops: const <double>[0.0, 1.0],
                colors: !widget.animated
                    ? <Color>[gradientStart, gradientEnd]
                    : <Color>[
                        _colorTween(gradientStart, gradientEnd),
                        _colorTween(gradientEnd, gradientStart),
                      ],
                tileMode: TileMode.clamp),
          ),
        );
      },
    );
  }

  Color _colorTween(Color begin, Color end) {
    return ColorTween(begin: begin, end: end).transform(_controller.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
