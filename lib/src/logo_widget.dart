import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
    required this.width,
    required this.scale,
    required this.imageLink,
    this.logoColor,
    this.fadeDuration,
  });
  final double width;
  final double scale;
  final String imageLink;
  final Color? logoColor;
  final Duration? fadeDuration;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: scale,
      duration: fadeDuration ?? const Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
      child: SizedBox(
        height: width,
        width: width,
        child: FittedBox(
          child: Image.asset(
            imageLink,
            color: logoColor,
          ),
        ),
      ),
    );
  }
}
