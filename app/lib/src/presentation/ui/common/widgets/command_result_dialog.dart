import 'package:app/src/presentation/ui/shell/view_model/shell_view_model.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';

class CommandResultDialog extends StatelessWidget {
  const CommandResultDialog.error({super.key, required this.authMessageType})
    : icon = Icons.error_outline,
      isError = true;

  const CommandResultDialog.success({super.key, required this.authMessageType})
    : icon = Icons.check,
      isError = false;

  final IconData icon;
  final bool isError;
  final AuthMessageType authMessageType;

  String? getDialogTitleMessage(
    BuildContext context,
    bool isError,
    AuthMessageType resultMessageType,
  ) {
    if (isError) {
      return AppIntl.of(context).shell_oops;
    }
    switch (resultMessageType) {
      case AuthMessageType.signIn:
        return AppIntl.of(context).shell_welcome_back;
      case AuthMessageType.signOut:
        return null;
      case AuthMessageType.createUser:
        return AppIntl.of(context).shell_welcome;
    }
  }

  String getDialogSubtitleMessage(
    BuildContext context,
    bool isError,
    AuthMessageType resultMessageType,
  ) {
    if (isError) {
      return AppIntl.of(context).shell_error_message;
    }
    switch (resultMessageType) {
      case AuthMessageType.signIn:
        return AppIntl.of(context).shell_sign_in_success_message;
      case AuthMessageType.signOut:
        return AppIntl.of(context).shell_sign_out_success_message;
      case AuthMessageType.createUser:
        return AppIntl.of(context).shell_sign_up_success_message;
    }
  }

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
    final titleMessage = getDialogTitleMessage(
      context,
      isError,
      authMessageType,
    );
    final subtitleMessage = getDialogSubtitleMessage(
      context,
      isError,
      authMessageType,
    );
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
              titleMessage,
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
