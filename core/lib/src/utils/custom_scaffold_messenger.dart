import 'package:flutter/material.dart';

enum MessageType { warning, error, success }

class CustomScaffoldMessenger {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static Color? _getBackgroundColor(MessageType type, BuildContext? context) {
    if (context == null) {
      return null;
    }
    switch (type) {
      case MessageType.warning:
        return null;
      case MessageType.error:
        return Theme.of(context).colorScheme.errorContainer;
      case MessageType.success:
        return Theme.of(context).colorScheme.primaryContainer;
    }
  }

  static Color? _getForegroundColor(MessageType type, BuildContext? context) {
    if (context == null) {
      return null;
    }
    switch (type) {
      case MessageType.warning:
        return null;
      case MessageType.error:
        return Theme.of(context).colorScheme.onErrorContainer;
      case MessageType.success:
        return Theme.of(context).colorScheme.onPrimaryContainer;
    }
  }

  static TextStyle? _getTextStyle(MessageType type, BuildContext? context) {
    if (context == null) {
      return null;
    }
    return Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: _getForegroundColor(type, context));
  }

  static double? _getWidth(BuildContext? context) {
    if (context == null) {
      return null;
    }
    final width = MediaQuery.sizeOf(context).width;
    if (width < 750) {
      return width * 0.6;
    } else {
      return width * 0.4;
    }
  }

  static void _showSnackBar(String message, MessageType type) {
    final context = scaffoldMessengerKey.currentContext;
    scaffoldMessengerKey.currentState?.clearSnackBars();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message, style: _getTextStyle(type, context)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
        closeIconColor: _getForegroundColor(type, context),
        backgroundColor: _getBackgroundColor(type, context),
        width: _getWidth(context),
        showCloseIcon: true,
      ),
    );
  }

  static showErrorSnackBar(String message) {
    _showSnackBar(message, MessageType.error);
  }

  static showSuccessSnackBar(String message) {
    _showSnackBar(message, MessageType.success);
  }

  static showWarningSnackBar(String message) {
    _showSnackBar(message, MessageType.warning);
  }
}
