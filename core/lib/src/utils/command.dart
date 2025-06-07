import 'dart:async';

import 'package:core/src/utils/result.dart';
import 'package:flutter/foundation.dart';

typedef CommandAction0<T> = AsyncResult<T> Function();
typedef CommandAction1<T, A> = AsyncResult<T> Function(A);
typedef AsyncResult<T> = Future<Result<T>>;

enum CommandState { init, loading, error, completed }

abstract class Command<T> extends ChangeNotifier {
  CommandState _state = CommandState.init;

  CommandState get state => _state;

  bool get running => _state == CommandState.loading;

  Result<T>? _result;

  Result<T>? get result => _result;

  void clearResult() {
    _result = null;
    notifyListeners();
  }

  Future<void> _execute(CommandAction0<T> action) async {
    if (_state == CommandState.loading) return;

    _state = CommandState.loading;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _state = switch (_result) {
        Ok<T>() => CommandState.completed,
        Error<T>() => CommandState.error,
        _ => CommandState.init,
      };
      notifyListeners();
    }
  }
}

final class Command0<T> extends Command<T> {
  Command0(this._action);

  final CommandAction0<T> _action;

  Future<void> execute() async {
    await _execute(() => _action());
  }
}

final class Command1<T, A> extends Command<T> {
  Command1(this._action);

  final CommandAction1<T, A> _action;

  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}
