import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PosterCard extends StatelessWidget {
  const PosterCard({
    super.key,
    required this.posterPath,
    required this.rating,
    this.borderRadius = Dimensions.radiusMd,
    this.boxFit = BoxFit.scaleDown,
    this.height,
    this.width,
    this.placeholder,
    required this.infoWidget,
  });

  final String posterPath;
  final double rating;
  final double borderRadius;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final Widget? placeholder;
  final Widget infoWidget;

  static const posterImageFlex = 750;
  static const posterInfoFlex = 250;
  static const posterSpacingFlex = 1;
  static const posterImageProportion =
      750 / (posterImageFlex + posterInfoFlex + posterSpacingFlex);

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Dimensions.spacingXs,
      children: [
        Expanded(
          flex: posterImageFlex,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: ColoredBox(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              child: CustomNetworkImage(
                url: posterPath,
                boxFit: BoxFit.cover,
                height: height,
                width: width,
                placeholder:
                    placeholder ??
                    Center(
                      child: DefaultPlaceholder(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                errorWidget: Center(
                  child: DefaultErrorWidget(
                    iconColor: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ),
        Spacer(flex: posterSpacingFlex),
        Expanded(
          flex: posterInfoFlex,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: EdgeInsets.all(Dimensions.spacingSm),
            width: double.infinity,
            child: infoWidget,
          ),
        ),
      ],
    );
  }
}
