import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.content,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(Dimensions.spacingMd),
    this.borderRadius = Dimensions.radiusLg,
    this.title,
  });

  final Widget content;
  final String? title;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
        color: Theme.of(context).colorScheme.surface,
      ),
      padding: padding,
      child: Column(
        spacing: Dimensions.spacingMd,
        children: [
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          Expanded(child: content),
        ],
      ),
    );
  }
}
