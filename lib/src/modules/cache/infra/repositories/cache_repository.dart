import '../../../../core/core.dart';

import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';
import '../../domain/repositories/i_cache_repository.dart';
import '../datasources/i_key_value_storage_datasource.dart';

class CacheRepository implements ICacheRepository {
  final IKeyValueStorageDatasource _kvsDatasource;

  const CacheRepository(this._kvsDatasource);

  @override
  Future<Either<AutoCacheManagerException, CacheEntity<T>?>> findByKey<T>(String key) async {
    try {
      
      throw UnimplementedError();
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }

  @override
  Future<Either<AutoCacheManagerException, Unit>> save<T>(SaveCacheDTO<T> dto) async {
    try {
      throw UnimplementedError();
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }
}
