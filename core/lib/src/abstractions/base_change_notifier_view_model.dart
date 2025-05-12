import 'package:core/src/abstractions/base_view_model.dart';
import 'package:flutter/foundation.dart';

abstract class BaseChangeNotifierViewModel extends BaseViewModel
    with ChangeNotifier {
  bool _initialized = false;

  @mustCallSuper
  void onReady() {}

  @mustCallSuper
  void onDispose() {
    _initialized = false;
    super.dispose();
  }

  void initialize() {
    if (!_initialized) {
      onInit();
      _initialized = true;
    }
  }
}
