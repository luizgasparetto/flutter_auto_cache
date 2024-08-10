part of '../chain_handler.dart';

abstract class AsyncChainHandler<T extends Object, V extends Object> extends ChainHandler<AsyncEither<AutoCacheFailure, T>, V> {
  covariant AsyncChainHandler<T, V>? _nextHandler;

  @override
  AsyncChainHandler<T, V>? get nextHandler => _nextHandler;

  @override
  void setNext(covariant AsyncChainHandler<T, V> handler) => _nextHandler = handler;
}
