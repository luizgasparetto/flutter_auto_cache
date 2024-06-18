// coverage:ignore-file

typedef AsyncEither<TLeft, TRight> = Future<Either<TLeft, TRight>>;

abstract class Either<TLeft, TRight> {
  bool get isError;
  bool get isSuccess;

  TLeft get error;
  TRight get success;

  T fold<T>(T Function(TLeft l) leftFn, T Function(TRight r) rightFn);

  T? foldLeft<T>(T Function(TLeft l) leftFn);

  Either<TLeft, TNewRight> mapRight<TNewRight>(TNewRight Function(TRight r) rightFn);
}

class _Left<TLeft, TRight> extends Either<TLeft, TRight> {
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
  T? foldLeft<T>(T Function(TLeft l) leftFn) {
    return leftFn(value);
  }

  @override
  Either<TLeft, TNewRight> mapRight<TNewRight>(TNewRight Function(TRight r) rightFn) {
    return _Left<TLeft, TNewRight>(value);
  }
}

class _Right<TLeft, TRight> extends Either<TLeft, TRight> {
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
  T? foldLeft<T>(T Function(TLeft l) leftFn) {
    return null;
  }

  @override
  Either<TLeft, TNewRight> mapRight<TNewRight>(TNewRight Function(TRight r) rightFn) {
    return _Right<TLeft, TNewRight>(rightFn(value));
  }
}

Either<TLeft, TRight> right<TLeft, TRight>(TRight r) {
  return _Right<TLeft, TRight>(r);
}

Either<TLeft, TRight> left<TLeft, TRight>(TLeft l) {
  return _Left<TLeft, TRight>(l);
}

abstract class Unit {}

class _Unit implements Unit {
  const _Unit();
}

const unit = _Unit();
