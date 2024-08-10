part of '../chain_handler.dart';

abstract class SyncChainHandler<Value extends Object> extends ChainHandler<Value> {
  covariant SyncChainHandler<Value>? _nextHandler;

  @override
  SyncChainHandler<Value>? get nextHandler => _nextHandler;

  @override
  void setNext(covariant SyncChainHandler<Value> handler) => _nextHandler = handler;

  @override
  Either<AutoCacheFailure, Unit> handle(Value value);
}
