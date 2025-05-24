import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgImage extends StatelessWidget {
  const CustomSvgImage({
    super.key,
    required this.assetName,
    this.colorFilter,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String assetName;
  final ColorFilter? colorFilter;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      colorFilter: colorFilter,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
