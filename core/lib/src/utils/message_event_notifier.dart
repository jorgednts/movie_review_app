import 'package:flutter/foundation.dart';

class MessageEventNotifier<T> extends ChangeNotifier {
  T? _dialogEventType;

  void trigger(T type) {
    _dialogEventType = type;
    notifyListeners();
  }

  T? consumeEvent() {
    final event = _dialogEventType;
    _dialogEventType = null;
    return event;
  }
}
