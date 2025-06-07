sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok._;

  const factory Result.error(Exception error) = Error._;

  void fold({
    required void Function(T value) onOk,
    required void Function(Exception error) onError,
  }) {
    switch (this) {
      case Ok<T>(:final value):
        onOk(value);
      case Error<T>(:final error):
        onError(error);
    }
  }
}

final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

final class Error<T> extends Result<T> {
  const Error._(this.error);

  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}
