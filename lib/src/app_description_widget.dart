import 'package:flutter/material.dart';

class AppDescription extends StatelessWidget {
  const AppDescription({
    super.key,
    this.appDescription,
  });
  final Text? appDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: appDescription);
  }
}
