abstract class Either<TLeft, TRight> {
  bool get isLeft;
  bool get isRight;

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
}

class _Left<TLeft, TRight> extends Either<TLeft, TRight> {
  final TLeft _value;

  @override
  final bool isLeft = true;

  @override
  final bool isRight = false;

  _Left(this._value);

  @override
  T fold<T>(T Function(TLeft l) leftFn, T Function(TRight r) rightFn) {
    return leftFn(_value);
  }

  @override
  TRight getOrElse(TRight Function(TLeft l) orElse) {
    return orElse(_value);
  }
}

class _Right<TLeft, TRight> extends Either<TLeft, TRight> {
  final TRight _value;

  @override
  final bool isLeft = false;

  @override
  final bool isRight = true;

  _Right(this._value);

  @override
  T fold<T>(T Function(TLeft l) leftFn, T Function(TRight r) rightFn) {
    return rightFn(_value);
  }

  @override
  TRight getOrElse(TRight Function(TLeft l) orElse) {
    return _value;
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
