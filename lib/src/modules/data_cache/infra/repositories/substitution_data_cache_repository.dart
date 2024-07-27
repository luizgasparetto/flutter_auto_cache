import '../../../../core/shared/errors/auto_cache_error.dart';
import '../../../../core/shared/functional/either.dart';
import '../../domain/entities/data_cache_entity.dart';

import '../../domain/repositories/i_data_cache_repository.dart';
import '../datasources/i_query_data_cache_datasource.dart';

final class SubstitutionDataCacheRepository implements ISubstitutionDataCacheRepository {
  final IQueryDataCacheDatasource datasource;

  const SubstitutionDataCacheRepository(this.datasource);

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
  Either<AutoCacheException, List<DataCacheEntity?>> getAll() {
    try {
      final response = datasource.getAll();

      return right(response);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheException, bool> accomodateCache<T extends Object>(DataCacheEntity<T> cache, {String? key}) async {
    try {
      final response = await datasource.accomodateCache(cache);

      return right(response);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }
}
