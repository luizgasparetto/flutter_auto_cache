import '../../errors/auto_cache_error.dart';
import '../../functional/either.dart';

abstract class SyncChainHandler<T extends Object> {
  SyncChainHandler<T>? nextHandler;

  void setNext(SyncChainHandler<T> handler) => nextHandler = handler;

  Either<AutoCacheFailure, T> handle(String url);
}

abstract class AsyncChainHandler<T extends Object> {
  AsyncChainHandler<T>? nextHandler;

  void setNext(AsyncChainHandler<T> handler) => nextHandler = handler;

  AsyncEither<AutoCacheFailure, T> handle(String url);
}
