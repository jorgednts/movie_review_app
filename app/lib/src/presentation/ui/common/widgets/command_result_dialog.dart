import 'package:app/src/presentation/ui/shell/view_model/shell_view_model.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';

class CommandResultDialog extends StatelessWidget {
  const CommandResultDialog({
    super.key,
    required this.authMessageType,
    this.message,
  }) : icon = Icons.check,
       isError =
           authMessageType == AuthMessageType.errorSignIn ||
           authMessageType == AuthMessageType.errorSignOut ||
           authMessageType == AuthMessageType.errorCreateUser;

  final IconData icon;
  final bool isError;
  final AuthMessageType authMessageType;
  final String? message;

  String? getDialogTitleMessage(
    BuildContext context,
    AuthMessageType resultMessageType,
  ) {
    if (isError) {
      return AppIntl.of(context).shell_oops;
    }
    switch (resultMessageType) {
      case AuthMessageType.successSignIn:
        return AppIntl.of(context).shell_welcome_back;
      case AuthMessageType.successSignOut:
        return null;
      case AuthMessageType.successCreateUser:
        return AppIntl.of(context).shell_welcome;
      case AuthMessageType.successDeleteUser:
        return AppIntl.of(context).shell_success;
      case AuthMessageType.errorSignIn:
      case AuthMessageType.errorSignOut:
      case AuthMessageType.errorCreateUser:
      case AuthMessageType.errorDeleteUser:
        return AppIntl.of(context).shell_oops;
    }
  }

  String getDialogSubtitleMessage(
    BuildContext context,
    AuthMessageType resultMessageType,
  ) {
    if (message != null) {
      return message!;
    }
    if (isError) {
      return AppIntl.of(context).shell_error_message;
    }
    switch (resultMessageType) {
      case AuthMessageType.successSignIn:
        return AppIntl.of(context).shell_sign_in_success_message;
      case AuthMessageType.successSignOut:
        return AppIntl.of(context).shell_sign_out_success_message;
      case AuthMessageType.successCreateUser:
        return AppIntl.of(context).shell_sign_up_success_message;
      case AuthMessageType.successDeleteUser:
        return AppIntl.of(context).shell_delete_user_success_message;
      case AuthMessageType.errorSignIn:
      case AuthMessageType.errorSignOut:
      case AuthMessageType.errorCreateUser:
      case AuthMessageType.errorDeleteUser:
        return AppIntl.of(context).shell_error_message;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor =
        isError
            ? theme.colorScheme.errorContainer
            : theme.colorScheme.onPrimaryContainer;
    final iconBackgroundColor =
        isError
            ? theme.colorScheme.onErrorContainer
            : theme.colorScheme.primaryContainer;
    final titleMessage = getDialogTitleMessage(context, authMessageType);
    final subtitleMessage = getDialogSubtitleMessage(context, authMessageType);
    return ConstrainedDialog(
      boxConstraints: BoxConstraints(
        maxWidth: 250,
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      onPop: context.pop,
      title: Center(
        child: PulsatingOpacityContainer(
          color: iconBackgroundColor,
          padding: const EdgeInsets.all(Dimensions.spacingMd),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBackgroundColor,
            ),
            padding: const EdgeInsets.all(Dimensions.spacingMd),
            child: Icon(icon, color: iconColor),
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (titleMessage != null)
            StyledText.t2(
              titleMessage,
              textAlign: TextAlign.center,
              isBold: true,
            ),
          StyledText.t2(subtitleMessage, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
