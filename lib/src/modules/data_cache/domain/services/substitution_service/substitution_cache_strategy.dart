import '../../../../../core/core.dart';

typedef SubstitutionCallback = AsyncEither<AutoCacheError, Unit> Function();

abstract interface class ISubstitutionCacheStrategy {
  AsyncEither<AutoCacheError, Unit> substitute(SubstitutionCallback callback);
}
