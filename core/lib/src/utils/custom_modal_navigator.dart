import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CustomModalNavigator {
  static final modalNavigatorKey = GlobalKey<NavigatorState>();

  static AsyncResult<T?> showCustomBottomSheet<T>(
    Widget bottomSheet, {
    bool isDismissible = true,
    ShapeBorder shape = const RoundedRectangleBorder(),
    Color? backgroundColor,
    BoxConstraints? constraints,
  }) async {
    final context = modalNavigatorKey.currentContext;
    if (context != null) {
      final result = await showModalBottomSheet<T>(
        context: context,
        isDismissible: isDismissible,
        shape: shape,
        backgroundColor: backgroundColor ?? Colors.transparent,
        enableDrag: true,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) => bottomSheet,
      );
      return Result.ok(result);
    } else {
      return Result.error(ContextNotFoundException());
    }
  }

  static AsyncResult<T?> showCustomAdaptiveDialog<T>(
    Widget dialog, {
    bool isDismissible = true,
  }) async {
    final context = modalNavigatorKey.currentContext;
    if (context != null) {
      final result = await showAdaptiveDialog<T>(
        context: context,
        barrierDismissible: isDismissible,
        builder: (_) => dialog,
      );
      return Result.ok(result);
    } else {
      return Result.error(ContextNotFoundException());
    }
  }
}

class ContextNotFoundException implements Exception {}
