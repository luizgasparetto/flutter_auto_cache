import 'dart:async';

import '../../errors/auto_cache_error.dart';
import '../../functional/either.dart';

abstract class ChainHandler<Value extends Object, Error extends AutoCacheError> {
  ChainHandler<Object, Error>? nextHandler;

  void setNext(ChainHandler<Object, Error> handler) => nextHandler = handler;

  FutureOr<Either<Error, Unit>> handle(Value value);
}
