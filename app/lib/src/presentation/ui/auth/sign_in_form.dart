import 'package:app/src/presentation/ui/auth/auth_form.dart';
import 'package:app/src/presentation/utils/form_field_validators.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
    required this.signInCommand,
    required this.handleTextButtonPress,
  });

  final Command1<void, UserRequest> signInCommand;
  final VoidCallback handleTextButtonPress;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: AppIntl.of(context).shell_sign_in_title,
      command: widget.signInCommand,
      onSubmit:
          () => UserRequest(
            email: emailController.text,
            password: passwordController.text,
            name: '',
          ),
      primaryButtonLabel: AppIntl.of(context).shell_sign_in,
      secondaryButtonLabel: AppIntl.of(context).shell_create_user_message,
      onSecondaryPressed: widget.handleTextButtonPress,
      fields: [
        DefaultTextFormField(
          controller: emailController,
          label: AppIntl.of(context).shell_email,
          maxLines: 1,
          validator: (v) => FormFieldValidators.validateEmail(v, context),
        ),
        DefaultTextFormField(
          controller: passwordController,
          label: AppIntl.of(context).shell_password,
          maxLines: 1,
          obscureText: true,
          validator: (v) => FormFieldValidators.validatePassword(v, context),
        ),
      ],
    );
  }
}
