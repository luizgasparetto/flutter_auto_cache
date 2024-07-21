import '../../../../core/core_module.dart';
import '../../../../core/functional/either.dart';
import '../../domain/entities/data_cache_entity.dart';
import '../../domain/repositories/i_substitute_data_cache_repository.dart';
import '../datasources/i_query_data_cache_datasource.dart';

final class SubstituteDataCacheRepository implements ISubstituteDataCacheRepository {
  final IQueryDataCacheDatasource datasource;

  const SubstituteDataCacheRepository({required this.datasource});

  @override
  Either<AutoCacheException, List<String>> getKeys() {
    try {
      final response = datasource.getKeys();

      return right(response);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheException, bool> accomodateCache<T extends Object>(DataCacheEntity<T> cache, {bool recursive = false}) async {
    try {
      final response = await datasource.accomodateCache(cache);

      return right(response);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }
}
