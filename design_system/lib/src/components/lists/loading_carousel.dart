import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class LoadingCarousel extends StatelessWidget {
  const LoadingCarousel({
    super.key,
    this.itemCount = 5,
    required this.itemExtent,
    required this.viewportDimension,
    required this.padding,
  });

  final int itemCount;
  final double itemExtent;
  final double viewportDimension;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      controller: CarouselController(),
      itemExtent: itemExtent,
      padding: padding,
      viewportDimension: viewportDimension,
      children: List.generate(itemCount, (index) {
        return ShimmerLoading(
          child: Container(
            width: itemExtent,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.radiusMd),
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: const UnconstrainedBox(),
          ),
        );
      }),
    );
  }
}
