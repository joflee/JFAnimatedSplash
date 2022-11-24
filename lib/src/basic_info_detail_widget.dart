import 'package:flutter/material.dart';

class BasicInfoDetailWidget extends StatelessWidget {
  const BasicInfoDetailWidget({
    super.key,
    required this.appOrigin,
    required this.companyName,
    this.bottomWidget,
    required this.version,
  });
  final Text? appOrigin;
  final Text? companyName;
  final Text? version;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return bottomWidget ??
        Column(
          children: [
            version ?? const SizedBox.shrink(),
            const SizedBox(
              height: 5,
            ),
            appOrigin ?? const SizedBox.shrink(),
            const SizedBox(
              height: 5,
            ),
            companyName ?? const SizedBox.shrink(),
          ],
        );
  }
}
