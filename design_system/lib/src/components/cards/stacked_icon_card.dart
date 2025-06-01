import 'package:flutter/material.dart';

import '../../tokens/dimensions/dimensions.dart';

/// Stacks an [icon] on top of a card with [message], which is styled with
/// [messageStyle]. The message card is padded within the [constraints]
/// using [messagePadding].

class StackedIconCard extends StatelessWidget {
  final String message;
  final IconData icon;
  final TextStyle? messageStyle;
  final BoxConstraints constraints;
  final EdgeInsets messagePadding;
  final Color? messageCardColor;
  final Color? iconCardColor;
  final Color? iconColor;

  const StackedIconCard({
    super.key,
    required this.message,
    this.messageStyle,
    this.constraints = const BoxConstraints(maxWidth: 280),
    this.messagePadding = const EdgeInsets.all(Dimensions.spacingSm),
    this.icon = Icons.saved_search,
    this.messageCardColor,
    this.iconCardColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.spacingMd),
            child: Card(
              color:
                  messageCardColor ??
                  Theme.of(context).colorScheme.surfaceContainerHigh,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.spacingMd),
                child: Text(
                  message,
                  style:
                      messageStyle ??
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                ),
              ),
            ),
          ),
          Card(
            color:
                iconCardColor ??
                Theme.of(context).colorScheme.secondaryContainer,
            shape: CircleBorder(),
            child: Padding(
              padding: messagePadding,
              child: Icon(
                icon,
                color:
                    iconColor ??
                    Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
