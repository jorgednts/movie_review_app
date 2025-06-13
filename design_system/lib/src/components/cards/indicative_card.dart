import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class IndicativeCard extends StatelessWidget {
  const IndicativeCard({
    super.key,
    required this.message,
    this.indicatorSize = Dimensions.iconSizeXs,
    this.backgroundColor,
    this.messageStyle,
  });

  final String message;
  final double indicatorSize;
  final Color? backgroundColor;
  final TextStyle? messageStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipPath(
          clipper: TriangleClipper(),
          child: Container(
            color:
                backgroundColor ??
                Theme.of(context).colorScheme.primaryContainer,
            width: indicatorSize,
            height: indicatorSize,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color:
                backgroundColor ??
                Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(Dimensions.radiusMd),
          ),
          padding: const EdgeInsets.all(Dimensions.spacingMd),
          margin: const EdgeInsets.only(right: Dimensions.spacingMd),
          child: Text(
            message,
            style:
                messageStyle ??
                Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
