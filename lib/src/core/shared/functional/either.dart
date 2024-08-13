import 'dart:async';

import '../errors/auto_cache_error.dart';

typedef Result<TRight> = _Either<AutoCacheError, TRight>;

typedef AsyncResult<TRight> = FutureOr<_Either<AutoCacheError, TRight>>;

abstract class _Either<TLeft, TRight> {
  bool get isError;
  bool get isSuccess;

  TLeft get error;
  TRight get success;

  T fold<T>(T Function(TLeft l) leftFn, T Function(TRight r) rightFn);

  _Either<TLeft, TNewRight> mapRight<TNewRight>(TNewRight Function(TRight r) rightFn);
}

class _Left<TLeft, TRight> extends _Either<TLeft, TRight> {
  final TLeft value;

  @override
  final bool isError = true;

  @override
  final bool isSuccess = false;

  _Left(this.value);

  @override
  T fold<T>(T Function(TLeft l) leftFn, T Function(TRight r) rightFn) {
    return leftFn(value);
  }

  @override
  TLeft get error => value;

  @override
  TRight get success => throw UnimplementedError();

  @override
  _Either<TLeft, TNewRight> mapRight<TNewRight>(TNewRight Function(TRight r) rightFn) {
    return _Left<TLeft, TNewRight>(value);
  }
}

class _Right<TLeft, TRight> extends _Either<TLeft, TRight> {
  final TRight value;

  @override
  final bool isError = false;

  @override
  final bool isSuccess = true;

  _Right(this.value);

  @override
  T fold<T>(T Function(TLeft l) leftFn, T Function(TRight r) rightFn) {
    return rightFn(value);
  }

  @override
  TLeft get error => throw UnimplementedError();

  @override
  TRight get success => value;

  @override
  _Either<TLeft, TNewRight> mapRight<TNewRight>(TNewRight Function(TRight r) rightFn) {
    return _Right<TLeft, TNewRight>(rightFn(value));
  }
}

_Either<TLeft, TRight> right<TLeft, TRight>(TRight r) {
  return _Right<TLeft, TRight>(r);
}

_Either<TLeft, TRight> left<TLeft, TRight>(TLeft l) {
  return _Left<TLeft, TRight>(l);
}

abstract class Unit {}

class _Unit implements Unit {
  const _Unit();
}

const unit = _Unit();
