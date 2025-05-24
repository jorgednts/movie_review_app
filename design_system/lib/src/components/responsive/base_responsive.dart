import 'package:flutter/material.dart';

class BaseResponsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const BaseResponsive({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 750) {
          return desktop;
        }
        return mobile;
      },
    );
  }
}
