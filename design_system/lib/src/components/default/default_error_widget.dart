import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget({
    super.key,
    this.width,
    this.height,
    this.iconColor,
  });

  final double? width;
  final double? height;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Icon(
        Icons.image_not_supported_outlined,
        size: Dimensions.iconSizeLg,
        color: iconColor,
      ),
    );
  }
}
