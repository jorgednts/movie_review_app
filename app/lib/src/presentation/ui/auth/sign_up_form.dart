import 'package:app/src/presentation/ui/auth/auth_form.dart';
import 'package:app/src/presentation/utils/form_field_validators.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.signUpCommand,
    required this.handleTextButtonPress,
  });

  final Command1<void, UserRequest> signUpCommand;
  final VoidCallback handleTextButtonPress;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: AppIntl.of(context).shell_create_user_title,
      command: widget.signUpCommand,
      onSubmit:
          () => UserRequest(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
          ),
      primaryButtonLabel: AppIntl.of(context).shell_create_user,
      secondaryButtonLabel: AppIntl.of(context).shell_sign_in_message,
      onSecondaryPressed: widget.handleTextButtonPress,
      fields: [
        DefaultTextFormField(
          controller: nameController,
          label: AppIntl.of(context).common_name,
          maxLines: 1,
          validator: (v) => FormFieldValidators.validateString(v, context),
        ),
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
