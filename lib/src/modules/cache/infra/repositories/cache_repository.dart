import '../../../../auto_cache_manager_initializer.dart';
import '../../../../core/core.dart';

import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/repositories/i_cache_repository.dart';
import '../../domain/types/cache_types.dart';
import '../datasources/i_key_value_storage_datasource.dart';
import '../datasources/i_sql_storage_datasource.dart';

class CacheRepository implements ICacheRepository {
  final IKeyValueStorageDatasource _kvsDatasource;
  final ISQLStorageDatasource _sqlDatasource;

  const CacheRepository(this._kvsDatasource, this._sqlDatasource);

  @override
  Future<GetCacheResponse<T>> findByKey<T extends Object>(String key) async {
    try {
      final config = AutoCacheManagerInitialazer.I.config;
      final action = config.isKvsSelected ? _kvsDatasource.findByKey : _sqlDatasource.findByKey;

      final response = await action.call<T>(key);

      return right(response);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }

  @override
  Future<Either<AutoCacheManagerException, Unit>> save<T extends Object>(SaveCacheDTO<T> dto) async {
    try {
      final config = AutoCacheManagerInitialazer.I.config;
      final action = config.isKvsSelected ? _kvsDatasource.save : _sqlDatasource.save;

      await action.call<T>(dto);

      return right(unit);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }
}
