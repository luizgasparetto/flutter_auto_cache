part of '../chain_handler.dart';

abstract class SyncChainHandler<T extends Object, V extends Object> extends ChainHandler<Either<AutoCacheFailure, T>, V> {
  covariant SyncChainHandler<T, V>? _nextHandler;

  @override
  SyncChainHandler<T, V>? get nextHandler => _nextHandler;

  @override
  void setNext(covariant SyncChainHandler<T, V> handler) => _nextHandler = handler;
}
