import '../../../../core/core.dart';
import '../../domain/entities/data_cache_entity.dart';
import '../../domain/repositories/i_substitution_data_cache_repository.dart';

final class SubstitutionDataCacheRepository implements ISubstitutionDataCacheRepository {
  @override
  AsyncEither<AutoCacheError, Unit> updateCacheUsage<T extends Object>(DataCacheEntity<T> cache) async {
    throw UnimplementedError();
  }
}
