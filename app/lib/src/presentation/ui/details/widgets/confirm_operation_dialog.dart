import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';

class ConfirmOperationDialog extends StatelessWidget {
  const ConfirmOperationDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return ConstrainedDialog(
      boxConstraints: BoxConstraints(
        maxWidth: 400,
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      onPop: context.pop,
      title: Align(
        child: Text(
          AppIntl.of(context).common_confirm_operation,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Dimensions.spacingLg,
        children: [
          Flexible(
            child: Text(message, style: Theme.of(context).textTheme.bodyLarge),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => context.pop(false),
                child: Text(AppIntl.of(context).common_cancel),
              ),
              FilledButton(
                onPressed: () => context.pop(true),
                child: Text(AppIntl.of(context).common_confirm),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
