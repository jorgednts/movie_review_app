import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DefaultNavigationMenu extends StatelessWidget {
  const DefaultNavigationMenu({
    super.key,
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final List<String> destinations;
  final int currentIndex;
  final void Function(int index) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Dimensions.spacingLg,
      runSpacing: Dimensions.spacingMd,
      children: List.generate(destinations.length, (index) {
        final destination = destinations[index];
        final isSelected = currentIndex == index;

        return InkWell(
          onTap: () => onDestinationSelected(index),
          overlayColor: WidgetStateColor.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StyledText.h1(destination, isBold: true),
              const SizedBox(height: Dimensions.spacingXs),
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 300),
                tween: Tween(begin: 0, end: isSelected ? 1.0 : 0.0),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 8 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  height: 4,
                  width: 25,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
