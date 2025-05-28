import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommandResultDialog extends StatelessWidget {
  const CommandResultDialog({
    super.key,
    this.titleMessage,
    required this.icon,
    required this.subtitleMessage,
    required this.isError,
  });

  const CommandResultDialog.error({
    super.key,
    this.titleMessage,
    this.icon = Icons.error_outline,
    required this.subtitleMessage,
    this.isError = true,
  });

  const CommandResultDialog.success({
    super.key,
    this.titleMessage,
    this.icon = Icons.check,
    required this.subtitleMessage,
    this.isError = false,
  });

  final String? titleMessage;
  final String subtitleMessage;
  final IconData icon;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final iconColor =
        isError
            ? Theme.of(context).colorScheme.errorContainer
            : Theme.of(context).colorScheme.onPrimaryContainer;
    final iconBackgroundColor =
        isError
            ? Theme.of(context).colorScheme.onErrorContainer
            : Theme.of(context).colorScheme.primaryContainer;
    return ConstrainedDialog(
      boxConstraints: BoxConstraints(
        maxWidth: 250,
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      onPop: () => context.pop(),
      title: Center(
        child: PulsatingOpacityContainer(
          color: iconBackgroundColor,
          padding: EdgeInsets.all(Dimensions.spacingMd),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBackgroundColor,
            ),
            padding: EdgeInsets.all(Dimensions.spacingMd),
            child: Icon(icon, color: iconColor),
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (titleMessage != null)
            Text(
              titleMessage!,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          Text(
            subtitleMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
