import 'dart:async';

extension FutureOrDirectValue<T> on FutureOr<T> {
  T ignoreFuture() {
    if (this is Future<T>) throw StateError('This is a Future, not a direct value');

    return this as T;
  }
}
