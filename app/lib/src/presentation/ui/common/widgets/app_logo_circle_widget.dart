import 'package:app/src/presentation/common/constants/image_constants.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppLogoCircleWidget extends StatelessWidget {
  final EdgeInsets padding;
  final double? radius;

  const AppLogoCircleWidget({
    super.key,
    this.padding = const EdgeInsets.all(Dimensions.spacingMd),
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      padding: padding,
      child: CustomSvgImage(
        assetName: ImageConstants.appLogSmallSVG,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.surface,
          BlendMode.srcIn,
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
