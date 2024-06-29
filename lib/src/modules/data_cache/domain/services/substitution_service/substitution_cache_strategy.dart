import '../../../../../core/core.dart';

abstract interface class ISubstitutionCacheStrategy {
  AsyncEither<AutoCacheError, Unit> substitute();
}
