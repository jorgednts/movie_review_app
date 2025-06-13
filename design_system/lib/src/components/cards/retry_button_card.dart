import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class RetryButtonCard extends StatelessWidget {
  const RetryButtonCard({
    super.key,
    required this.message,
    this.icon,
    this.messageStyle,
    required this.messagePadding,
    this.messageCardColor,
    this.buttonColor,
    required this.buttonText,
    required this.onPressed,
    this.constraints = const BoxConstraints(maxWidth: 400),
  });

  final String message;
  final IconData? icon;
  final TextStyle? messageStyle;
  final EdgeInsets messagePadding;
  final Color? messageCardColor;
  final Color? buttonColor;
  final String buttonText;
  final VoidCallback onPressed;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.spacingLg),
            child: Card(
              color:
                  messageCardColor ??
                  Theme.of(context).colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.spacingMd),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: Dimensions.spacingSm,
                  children: [
                    Text(
                      message,
                      style:
                          messageStyle ??
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                    FilledButton.icon(
                      onPressed: onPressed,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          buttonColor ?? Theme.of(context).colorScheme.error,
                        ),
                      ),
                      label: Text(
                        buttonText,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.error,
            shape: const CircleBorder(),
            child: Padding(
              padding: messagePadding,
              child: Icon(
                icon ?? Icons.sentiment_very_dissatisfied,
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
