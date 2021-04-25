import 'package:date_night/config/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_animations/simple_animations.dart';

/// The custom background that will be displayed on most screens.
/// It can be animiated with the background fading between colors.
/// This can be useful to show a "thinking" state to the user and
/// provide feedback that the application is loading.
// ignore: must_be_immutable

class PageBackground extends StatelessWidget {
  const PageBackground({@required this.child});

  /// What will be displayed over the background.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [_svgBackground(), child],
      ),
    );
  }

  /// Poor performance
  Widget _animatedBackground() {
    return PlasmaRenderer(
      type: PlasmaType.infinity,
      particles: 5,
      color: Color.fromRGBO(165, 106, 184, 0.2),
      blur: 1.0,
      size: 1.0,
      speed: 0.50,
      offset: 0,
      blendMode: BlendMode.srcOver,
      particleType: ParticleType.circle,
      variation1: 0,
      variation2: 0,
      variation3: 0,
      rotation: 0,
      child: PlasmaRenderer(
        type: PlasmaType.infinity,
        particles: 10,
        color: Color.fromRGBO(188, 240, 254, 0.2),
        blur: 1.0,
        size: 1.0,
        speed: 0.50,
        offset: 0,
        blendMode: BlendMode.srcOver,
        particleType: ParticleType.circle,
        variation1: 0,
        variation2: 0,
        variation3: 0,
        rotation: 0,
      ),
    );
  }

  Widget _svgBackground() {
    if (ThemeConfig.backgroundImage.split(".")[1] == 'svg') {
      return SvgPicture.asset(ThemeConfig.backgroundImage, fit: BoxFit.cover);
    }
  }
}
