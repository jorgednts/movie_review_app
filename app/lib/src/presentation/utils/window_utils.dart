import 'package:flutter/material.dart';

class WindowUtils {
  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width > 750;
  }
}