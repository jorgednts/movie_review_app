import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.title,
    required this.command,
    required this.onSubmit,
    required this.fields,
    required this.primaryButtonLabel,
    required this.secondaryButtonLabel,
    required this.onSecondaryPressed,
  });

  final String title;
  final Command1<void, UserRequest> command;
  final UserRequest Function() onSubmit;
  final List<Widget> fields;
  final String primaryButtonLabel;
  final String secondaryButtonLabel;
  final VoidCallback onSecondaryPressed;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  String getErrorMessage(BuildContext context, Exception e) {
    if (e is CustomFirebaseAuthException) {
      switch (e.type) {
        case FirebaseAuthExceptionType.emailAlreadyInUse:
          return AppIntl.of(context).auth_email_already_in_use;
        case FirebaseAuthExceptionType.weakPassword:
          return AppIntl.of(context).auth_weak_password;
        case FirebaseAuthExceptionType.invalidEmail:
          return AppIntl.of(context).auth_invalid_email;
        case FirebaseAuthExceptionType.userNotFound:
          return AppIntl.of(context).auth_user_not_found;
        case FirebaseAuthExceptionType.wrongPassword:
          return AppIntl.of(context).auth_wrong_password;
        case FirebaseAuthExceptionType.networkRequestFailed:
          return AppIntl.of(context).auth_network_error;
        default:
          return AppIntl.of(context).shell_error_message;
      }
    }

    return AppIntl.of(context).auth_generic_error;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.command,
      builder: (_, __) {
        return Column(
          spacing: Dimensions.spacingMd,
          children: [
            StyledText.t3(widget.title),
            Form(
              key: _formKey,
              child: Column(
                spacing: Dimensions.spacingMd,
                children: widget.fields,
              ),
            ),
            FilledButton(
              onPressed:
                  widget.command.running
                      ? null
                      : () {
                        if (_formKey.currentState?.validate() ?? false) {
                          widget.command.execute(widget.onSubmit());
                        }
                      },
              child:
                  widget.command.running
                      ? const CircularProgressIndicator()
                      : Text(
                        widget.primaryButtonLabel,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
            ),
            if (!widget.command.running)
              TextButton(
                onPressed: widget.onSecondaryPressed,
                child: StyledText.b1(
                  widget.secondaryButtonLabel,
                  fontColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            if (widget.command.result case Error(:final error))
              StyledText.b2(
                getErrorMessage(context, error),
                fontColor: Theme.of(context).colorScheme.error,
              ),
          ],
        );
      },
    );
  }
}
