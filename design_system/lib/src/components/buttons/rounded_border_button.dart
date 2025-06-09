import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class RoundedBorderButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final String tooltip;
  final Widget? badge;

  const RoundedBorderButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimensions.spacingXs),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon),
            padding: const EdgeInsets.all(Dimensions.spacingMd),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(
                Theme.of(context).colorScheme.surface,
              ),
              shape: WidgetStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radiusLg),
                ),
              ),
            ),
            color: Theme.of(context).colorScheme.onSurface,
            tooltip: tooltip,
          ),
        ),
        if (badge != null) badge!,
      ],
    );
  }
}
