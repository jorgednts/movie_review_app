import 'package:app/src/presentation/ui/common/widgets/app_logo_circle_widget.dart';
import 'package:app/src/presentation/utils/form_field_validators.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';

enum AuthDialogState {
  init,
  signIn,
  create;

  String filledButtonLabel(BuildContext context) {
    switch (this) {
      case AuthDialogState.init:
        return '';
      case AuthDialogState.signIn:
        return AppIntl.of(context).shell_sign_in;
      case AuthDialogState.create:
        return AppIntl.of(context).shell_create_user;
    }
  }

  String messageLabel(BuildContext context, {bool inverse = false}) {
    switch (this) {
      case AuthDialogState.init:
        return '';
      case AuthDialogState.signIn:
        return inverse
            ? AppIntl.of(context).shell_create_user_message
            : AppIntl.of(context).shell_sign_in_message;
      case AuthDialogState.create:
        return inverse
            ? AppIntl.of(context).shell_sign_in_message
            : AppIntl.of(context).shell_create_user_message;
    }
  }

  String widgetTitle(BuildContext context) {
    switch (this) {
      case AuthDialogState.init:
        return '';
      case AuthDialogState.signIn:
        return AppIntl.of(context).shell_sign_in_title;
      case AuthDialogState.create:
        return AppIntl.of(context).shell_create_user_title;
    }
  }
}

class SignInDialog extends StatefulWidget {
  const SignInDialog({super.key});

  @override
  State<SignInDialog> createState() => _SignInDialogState();
}

class _SignInDialogState extends State<SignInDialog> {
  final _formKey = GlobalKey<FormState>();
  AuthDialogState state = AuthDialogState.init;
  late TextEditingController emailController,
      passwordController,
      nameController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void updateState(AuthDialogState newState) {
    setState(() {
      state = newState;
    });
  }

  void handleFilledButtonPress(bool isSignIn) {
    final userRequest = UserRequest(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );
    switch (state) {
      case AuthDialogState.init:
        isSignIn
            ? updateState(AuthDialogState.signIn)
            : updateState(AuthDialogState.create);
        break;
      case AuthDialogState.signIn:
        handleValidateForm(
          () => context.pop<AuthDialogResult>(
            AuthDialogResult.signIn(userRequest: userRequest),
          ),
        );
        break;
      case AuthDialogState.create:
        handleValidateForm(
          () => context.pop<AuthDialogResult>(
            AuthDialogResult.create(userRequest: userRequest),
          ),
        );
        break;
    }
  }

  void handleTextButtonPress(bool isSignIn) {
    if (isSignIn) {
      updateState(AuthDialogState.create);
    } else {
      updateState(AuthDialogState.signIn);
    }
  }

  void handleValidateForm(void Function() onValidate) {
    if (_formKey.currentState?.validate() ?? false) {
      onValidate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedDialog(
      boxConstraints: BoxConstraints(
        maxWidth: 400,
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      onPop: () => context.pop(),
      title: Center(child: AppLogoCircleWidget()),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Dimensions.spacingMd,
          children: [
            if (state != AuthDialogState.init) ...[
              Text(
                state.widgetTitle(context),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Form(
                key: _formKey,
                child: Column(
                  spacing: Dimensions.spacingMd,
                  children: [
                    if (state == AuthDialogState.create)
                      DefaultTextFormField(
                        key: ValueKey('name'),
                        controller: nameController,
                        label: AppIntl.of(context).common_name,
                        validator:
                            (value) => FormFieldValidators.validateString(
                              value,
                              context,
                            ),
                      ),
                    DefaultTextFormField(
                      key: ValueKey('email'),
                      controller: emailController,
                      label: AppIntl.of(context).shell_email,
                      validator:
                          (value) =>
                              FormFieldValidators.validateEmail(value, context),
                    ),
                    DefaultTextFormField(
                      key: ValueKey('password'),
                      controller: passwordController,
                      label: AppIntl.of(context).shell_password,
                      obscureText: true,
                      validator:
                          (value) => FormFieldValidators.validatePassword(
                            value,
                            context,
                          ),
                    ),
                  ],
                ),
              ),
            ],
            if (state != AuthDialogState.signIn) ...[
              if (state == AuthDialogState.init)
                _MessageWidget(state: AuthDialogState.create),
              FilledTextButton(
                onPressed: () => handleFilledButtonPress(false),
                label: AppIntl.of(context).shell_create_user,
              ),
            ],
            if (state == AuthDialogState.init)
              Text(
                AppIntl.of(context).shell_or.toUpperCase(),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            if (state != AuthDialogState.create) ...[
              if (state == AuthDialogState.init)
                _MessageWidget(state: AuthDialogState.signIn),
              FilledTextButton(
                onPressed: () => handleFilledButtonPress(true),
                label: AppIntl.of(context).shell_sign_in,
              ),
            ],
            if (state != AuthDialogState.init)
              TextButton(
                onPressed:
                    () =>
                        handleTextButtonPress(state == AuthDialogState.signIn),
                child: Text(
                  state.messageLabel(context, inverse: true),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MessageWidget extends StatelessWidget {
  const _MessageWidget({required this.state});

  final AuthDialogState state;

  @override
  Widget build(BuildContext context) {
    return Text(
      state.messageLabel(context),
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class AuthDialogResult {
  final AuthDialogState state;
  final UserRequest? userRequest;

  const AuthDialogResult({required this.state, required this.userRequest});

  const AuthDialogResult.signIn({
    this.state = AuthDialogState.signIn,
    required this.userRequest,
  });

  const AuthDialogResult.create({
    this.state = AuthDialogState.create,
    required this.userRequest,
  });
}
