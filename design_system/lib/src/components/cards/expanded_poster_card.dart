import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ExpandedPosterCard extends StatelessWidget {
  final String posterUrl;
  final double borderRadius;
  final BoxFit boxFit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Widget infoWidget;

  const ExpandedPosterCard({
    super.key,
    required this.posterUrl,
    this.borderRadius = Dimensions.radiusMd,
    this.boxFit = BoxFit.scaleDown,
    this.placeholder,
    required this.infoWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              bottomLeft: Radius.circular(borderRadius),
            ),
            child: CustomNetworkImage(
              url: posterUrl,
              boxFit: BoxFit.fitHeight,
              placeholder:
                  placeholder ??
                  Center(
                    child: DefaultPlaceholder(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
              errorWidget: Center(
                child:
                    errorWidget ??
                    DefaultErrorWidget(
                      iconColor: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(Dimensions.spacingMd),
              child: infoWidget,
            ),
          ),
        ],
      ),
    );
  }
}
