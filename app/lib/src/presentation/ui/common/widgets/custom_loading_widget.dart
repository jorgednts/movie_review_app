import 'package:app/src/presentation/common/constants/image_constants.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class CustomLoadingWidget extends StatelessWidget {
  final EdgeInsets padding;
  final double? radius;
  final String? message;

  const CustomLoadingWidget({
    super.key,
    this.padding = const EdgeInsets.all(Dimensions.spacingMd),
    this.radius,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RotatingAnimatedCircle(
          radius: radius,
          padding: padding,
          child: CustomSvgImage(
            assetName: ImageConstants.appLogSmallSVG,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.surface,
              BlendMode.srcIn,
            ),
            fit: BoxFit.cover,
          ),
        ),
        Text(
          message ?? AppIntl.of(context).shell_loading_message,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
