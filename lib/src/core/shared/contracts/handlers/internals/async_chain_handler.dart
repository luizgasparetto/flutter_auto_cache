// ignore_for_file: overridden_fields

part of '../chain_handler.dart';

abstract class AsyncChainHandler<T extends Object, V extends Object> extends ChainHandler<AsyncEither<AutoCacheFailure, T>, V> {
  @override
  covariant AsyncChainHandler<T, V>? _nextHandler;

  @override
  AsyncChainHandler<T, V>? get nextHandler => _nextHandler;

  @override
  set nextHandler(covariant AsyncChainHandler<T, V>? handler);

  @override
  void setNext(covariant AsyncChainHandler<T, V> handler);

  @override
  AsyncEither<AutoCacheFailure, T> handle(covariant V value);
}
