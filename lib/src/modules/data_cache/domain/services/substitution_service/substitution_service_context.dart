import '../../../../../core/core.dart';

abstract interface class ISubstitutionServiceContext {
  Either<AutoCacheError, Unit> substitute();
}

class SubstitutionServiceContext implements ISubstitutionServiceContext {
  final CacheConfiguration configuration;

  const SubstitutionServiceContext(this.configuration);

  @override
  Either<AutoCacheError, Unit> substitute() {
    return right(unit);
    // return switch  (configuration.invalidationType)
  }
}
