import 'package:date_night/config/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// The custom background that will be displayed on most screens.
/// It can be animiated with the background fading between colors.
/// This can be useful to show a "thinking" state to the user and
/// provide feedback that the application is loading.
// ignore: must_be_immutable
class PageBackground extends StatelessWidget {
  const PageBackground({required this.child});

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

  Widget _svgBackground() {
    if (ThemeConfig.backgroundImage.split(".")[1] == 'svg') {
      return SvgPicture.asset(ThemeConfig.backgroundImage, fit: BoxFit.cover);
    }
    throw Exception("Background image not found.");
  }
}
