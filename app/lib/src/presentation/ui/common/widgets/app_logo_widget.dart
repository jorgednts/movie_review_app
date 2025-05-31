import 'package:app/src/presentation/common/constants/image_constants.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSvgImage(
      assetName: ImageConstants.appLogoSVG,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.onSurface,
        BlendMode.srcIn,
      ),
    );
  }
}
