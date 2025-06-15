import 'package:app/src/presentation/ui/auth/sign_in_form.dart';
import 'package:app/src/presentation/ui/auth/sign_up_form.dart';
import 'package:app/src/presentation/ui/common/widgets/app_logo_circle_widget.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';

enum AuthDialogState { init, signIn, create }

class AuthDialog extends StatefulWidget {
  const AuthDialog({
    super.key,
    required this.signInCommand,
    required this.signUpCommand,
  });

  final Command1<void, UserRequest> signInCommand;
  final Command1<void, UserRequest> signUpCommand;

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  AuthDialogState state = AuthDialogState.init;

  @override
  void initState() {
    super.initState();
    widget.signInCommand.addListener(handleCommandResult);
    widget.signUpCommand.addListener(handleCommandResult);
  }

  @override
  void dispose() {
    widget.signInCommand.removeListener(handleCommandResult);
    widget.signUpCommand.removeListener(handleCommandResult);
    super.dispose();
  }

  void handleCommandResult() {
    if (widget.signInCommand.result case Ok()) {
      context.pop(true);
    }

    if (widget.signUpCommand.result case Ok()) {
      context.pop(true);
    }
  }

  void updateState(AuthDialogState newState) {
    setState(() {
      state = newState;
    });
  }

  void handleFilledButtonPress(bool isSignIn) {
    isSignIn
        ? updateState(AuthDialogState.signIn)
        : updateState(AuthDialogState.create);
  }

  void handleTextButtonPress(bool isSignIn) {
    if (isSignIn) {
      updateState(AuthDialogState.create);
    } else {
      updateState(AuthDialogState.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.signUpCommand,
        widget.signInCommand,
      ]),
      builder: (context, child) {
        return ConstrainedDialog(
          canPop: false,
          boxConstraints: BoxConstraints(
            maxWidth: 400,
            maxHeight: MediaQuery.sizeOf(context).height * 0.75,
          ),
          onPop:
              widget.signUpCommand.running || widget.signInCommand.running
                  ? null
                  : context.pop,
          title: const Center(child: AppLogoCircleWidget()),
          content: SingleChildScrollView(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: 0.0,
                    child: child,
                  ),
                );
              },
              child: switch (state) {
                AuthDialogState.init => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: Dimensions.spacingMd,
                    children: [
                      StyledText.b2(
                        AppIntl.of(context).shell_create_user_message,
                        isBold: true,
                      ),
                      FilledTextButton(
                        onPressed: () => handleFilledButtonPress(false),
                        label: AppIntl.of(context).shell_create_user,
                      ),
                      StyledText.b2(
                        AppIntl.of(context).shell_or.toUpperCase(),
                        isBold: true,
                      ),
                      StyledText.b2(
                        AppIntl.of(context).shell_sign_in_message,
                        isBold: true,
                      ),
                      FilledTextButton(
                        onPressed: () => handleFilledButtonPress(true),
                        label: AppIntl.of(context).shell_sign_in,
                      ),
                    ],
                  ),
                ),
                AuthDialogState.signIn => SignInForm(
                  signInCommand: widget.signInCommand,
                  handleTextButtonPress: () => handleTextButtonPress(true),
                ),
                AuthDialogState.create => SignUpForm(
                  signUpCommand: widget.signUpCommand,
                  handleTextButtonPress: () => handleTextButtonPress(false),
                ),
              },
            ),
          ),
        );
      },
    );
  }
}
