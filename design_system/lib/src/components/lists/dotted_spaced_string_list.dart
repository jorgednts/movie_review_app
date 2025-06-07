import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DottedSpacedStringList extends StatelessWidget {
  final List<String> items;

  const DottedSpacedStringList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(
        items.length * 2 - 1,
        (index) =>
            index % 2 == 0
                ? SelectableText(
                  items[index ~/ 2],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                )
                : Container(
                  height: Dimensions.radiusSm,
                  width: Dimensions.radiusSm,
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.spacingSm,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
      ),
    );
  }
}
