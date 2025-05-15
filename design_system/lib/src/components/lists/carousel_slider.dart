import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CarouselSlider extends StatelessWidget {
  const CarouselSlider({
    super.key,
    this.itemExtent,
    required this.children,
    required this.controller,
    this.onTapItem,
    this.useDynamicItemExtent = false,
  }) : assert(itemExtent != null || useDynamicItemExtent);

  final List<Widget> children;
  final double? itemExtent;
  final CarouselController controller;
  final void Function(int index)? onTapItem;
  final bool useDynamicItemExtent;

  double getDynamicItemExtent(double maxHeight) {
    final posterImageHeight = PosterCard.posterImageProportion * maxHeight;
    return posterImageHeight * (2 / 3);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final carouselHeight = constraints.maxHeight;
        return CarouselView(
          itemExtent:   useDynamicItemExtent
              ? getDynamicItemExtent(carouselHeight)
              : itemExtent!,
          controller: controller,
          onTap: onTapItem,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusMd),
          ),
          itemSnapping: true,
          children: children,
        );
      },
    );
  }
}
