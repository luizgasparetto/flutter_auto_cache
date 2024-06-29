import '../../../../../core/core.dart';

abstract interface class ISubstitutionCacheContext {
  Either<AutoCacheError, Unit> substitute();
}

class SubstitutionCacheContext implements ISubstitutionCacheContext {
  final CacheConfiguration configuration;

  const SubstitutionCacheContext(this.configuration);

  @override
  Either<AutoCacheError, Unit> substitute() {
    return right(unit);
    // return switch  (configuration.invalidationType)
  }
}
