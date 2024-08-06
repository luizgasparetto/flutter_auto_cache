import '../errors/auto_cache_error.dart';
import '../functional/either.dart';

abstract class ValueObject {
  Either<AutoCacheFailure, Unit> validate();
}
