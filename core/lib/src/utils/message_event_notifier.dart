import 'package:flutter/foundation.dart';

enum DefaultMessageType {
  success, error;
}

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
