abstract class Either<TLeft, TRight> {
  bool get isError;
  bool get isSuccess;

  TLeft get error;
  TRight get success;

  T fold<T>(T Function(TLeft l) leftFn, T Function(TRight r) rightFn);

  TRight getOrElse(TRight Function(TLeft left) orElse);

  Either<TLeft, T> map<T>(T Function(TRight r) fn) {
    return fold(left, (r) {
      return right(fn(r));
    });
  }

  Either<T, TRight> leftMap<T>(T Function(TLeft l) fn) {
    return fold(
      (l) {
        return left(fn(l));
      },
      right,
    );
  }

  TRight asRight() => (this as _Right).value;
  TLeft asLeft() => (this as _Left).value;
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
  TRight getOrElse(TRight Function(TLeft l) orElse) {
    return orElse(value);
  }

  @override
  TLeft get error => value;

  @override
  TRight get success => throw UnimplementedError();
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
  TRight getOrElse(TRight Function(TLeft l) orElse) {
    return value;
  }

  @override
  TLeft get error => throw UnimplementedError();

  @override
  TRight get success => value;
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
