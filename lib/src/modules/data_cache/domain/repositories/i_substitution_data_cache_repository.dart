import '../../../../core/core.dart';
import '../entities/data_cache_entity.dart';

abstract interface class ISubstitutionDataCacheRepository {
  AsyncEither<AutoCacheException, String> getFirstCacheKey();
  AsyncEither<AutoCacheException, String> getRandomCacheKey();
  AsyncEither<AutoCacheError, Unit> updateCacheUsage<T extends Object>(DataCacheEntity<T> cache);
}

abstract interface class AAAAAAAA {
  AsyncEither<AutoCacheException, String> getFirstCacheKey();
  AsyncEither<AutoCacheException, String> getRandomCacheKey();
}
