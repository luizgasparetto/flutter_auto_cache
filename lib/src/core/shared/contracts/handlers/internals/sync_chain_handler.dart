// ignore_for_file: overridden_fields

part of '../chain_handler.dart';

abstract class SyncChainHandler<T extends Object, V extends Object> extends ChainHandler<Either<AutoCacheFailure, T>, V> {
  @override
  covariant SyncChainHandler<T, V>? _nextHandler;

  @override
  SyncChainHandler<T, V>? get nextHandler => _nextHandler;

  @override
  set nextHandler(covariant SyncChainHandler<T, V>? handler);

  @override
  void setNext(covariant SyncChainHandler<T, V> handler);
}
