import '../../../../core/core.dart';
import '../../domain/dtos/clear_cache_dto.dart';
import '../../domain/dtos/delete_cache_dto.dart';
import '../../domain/dtos/get_cache_dto.dart';
import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';
import '../../domain/enums/storage_type.dart';
import '../../domain/repositories/i_cache_repository.dart';
import '../datasources/i_command_data_cache_datasource.dart';
import '../datasources/i_query_data_cache_datasource.dart';

class CacheRepository implements ICacheRepository {
  final IQueryDataCacheDatasource _queryDataCacheDatasource;
  final ICommandDataCacheDatasource _commandDataCacheDatasource;

  const CacheRepository(this._queryDataCacheDatasource, this._commandDataCacheDatasource);

  @override
  Either<AutoCacheManagerException, CacheEntity<T>?> get<T extends Object>(GetCacheDTO dto) {
    try {
      final response = _queryDataCacheDatasource.get<T>(dto.key);

      return right(response);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }

  @override
  Either<AutoCacheManagerException, List<String>> getKeys(StorageType storageType) {
    try {
      final response = _queryDataCacheDatasource.getKeys();

      return right(response);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheManagerException, Unit> save<T extends Object>(SaveCacheDTO<T> dto) async {
    try {
      await _commandDataCacheDatasource.save<T>(dto);

      return right(unit);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheManagerException, Unit> delete(DeleteCacheDTO dto) async {
    try {
      await _commandDataCacheDatasource.delete(dto.key);

      return right(unit);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheManagerException, Unit> clear(ClearCacheDTO dto) async {
    try {
      await _commandDataCacheDatasource.clear();

      return right(unit);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheManagerException, Unit> update<T extends Object>() async {
    throw UnimplementedError();
  }
}
