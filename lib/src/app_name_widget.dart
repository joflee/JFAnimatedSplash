import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({
    super.key,
    required this.appTitle,
  });
  final Text appTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: appTitle,
    );
  }
}