import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class EmptyCarousel extends StatelessWidget {
  const EmptyCarousel({
    super.key,
    this.itemCount = 12,
    required this.itemExtent,
    required this.viewportDimension,
    required this.padding,
    required this.message,
  });

  final int itemCount;
  final double itemExtent;
  final double viewportDimension;
  final double padding;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: CarouselSlider(
            itemExtent: itemExtent,
            controller: CarouselController(),
            padding: padding,
            viewportDimension: viewportDimension,
            children: List.generate(itemCount, (index) {
              return Container(
                width: itemExtent,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Dimensions.radiusMd),
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                child: const UnconstrainedBox(),
              );
            }),
          ),
        ),
        Center(
          child: StackedIconCard(
            message: message,
            icon: Icons.sentiment_neutral,
          ),
        ),
      ],
    );
  }
}
