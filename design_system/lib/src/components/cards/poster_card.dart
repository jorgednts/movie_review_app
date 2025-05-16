import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PosterCard extends StatelessWidget {
  const PosterCard({
    super.key,
    required this.posterUrl,
    this.borderRadius = Dimensions.radiusMd,
    this.boxFit = BoxFit.scaleDown,
    this.height,
    this.width,
    this.placeholder,
    required this.infoWidget,
  });

  final String posterUrl;
  final double borderRadius;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final Widget? placeholder;
  final Widget infoWidget;

  static const posterImageFlex = 750;
  static const posterInfoFlex = 250;
  static const posterImageProportion = 750 / (posterImageFlex + posterInfoFlex);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: posterImageFlex,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
            child: ColoredBox(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              child: CustomNetworkImage(
                url: posterUrl,
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
        Expanded(
          flex: posterInfoFlex,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius),
              ),
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
