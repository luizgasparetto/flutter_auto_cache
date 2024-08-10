part of '../chain_handler.dart';

abstract class AsyncChainHandler<Value extends Object> extends ChainHandler<Value> {
  covariant AsyncChainHandler<Value>? _nextHandler;

  @override
  AsyncChainHandler<Value>? get nextHandler => _nextHandler;

  @override
  void setNext(covariant AsyncChainHandler<Value> handler) => _nextHandler = handler;

  @override
  AsyncEither<AutoCacheFailure, Unit> handle(Value value);
}
