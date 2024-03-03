import '../../../../auto_cache_manager_initializer.dart';
import '../../../../core/core.dart';

import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';
import '../../domain/repositories/i_cache_repository.dart';
import '../datasources/i_key_value_storage_datasource.dart';
import '../datasources/i_sql_storage_datasource.dart';

class CacheRepository implements ICacheRepository {
  final IKeyValueStorageDatasource _kvsDatasource;
  final ISQLStorageDatasource _sqlDatasource;

  const CacheRepository(this._kvsDatasource, this._sqlDatasource);

  @override
  Future<Either<AutoCacheManagerException, CacheEntity<T>?>> findByKey<T>(String key) async {
    final config = AutoCacheManagerInitialazer.instance.config;

    try {
      if (config.isKvsSelected) {
        final kvsResponse = _kvsDatasource.findByKey<T>(key);

        return right(kvsResponse);
      }

      final sqlResponse = await _sqlDatasource.findByKey<T>(key);

      return right(sqlResponse);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }

  @override
  Future<Either<AutoCacheManagerException, Unit>> save<T>(SaveCacheDTO<T> dto) async {
    final config = AutoCacheManagerInitialazer.instance.config;

    try {
      throw UnimplementedError();
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }
}
