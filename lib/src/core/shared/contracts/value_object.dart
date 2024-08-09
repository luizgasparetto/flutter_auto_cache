import '../errors/auto_cache_error.dart';
import '../functional/either.dart';
import '../functional/equals.dart';

abstract class ValueObject extends Equals {
  Either<AutoCacheFailure, Unit> validate();
}
