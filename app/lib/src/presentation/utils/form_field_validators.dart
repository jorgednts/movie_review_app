import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class FormFieldValidators {
  static String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppIntl.of(context).shell_email_empty_error;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return AppIntl.of(context).shell_email_invalid_error;
    }

    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppIntl.of(context).shell_password_empty_error;
    }

    if (value.length < 6) {
      return AppIntl.of(context).shell_password_short_error;
    }

    return null;
  }

  static String? validateString(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppIntl.of(context).common_empty_field;
    }
    return null;
  }
}
