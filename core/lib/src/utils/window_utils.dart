import 'package:flutter/material.dart';

class WindowUtils {
  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width > 750;
  }
  
  static double widthOf(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }
  
  static double heightOf(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
}
