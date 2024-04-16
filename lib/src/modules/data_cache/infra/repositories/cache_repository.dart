import '../../../../core/core.dart';
import '../../domain/dtos/clear_cache_dto.dart';
import '../../domain/dtos/get_cache_dto.dart';
import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/repositories/i_cache_repository.dart';
import '../../domain/types/cache_types.dart';
import '../datasources/i_prefs_cache_datasource.dart';
import '../datasources/i_sql_cache_datasource.dart';

class CacheRepository implements ICacheRepository {
  final IPrefsCacheDatasource _prefsDatasource;
  final ISQLCacheDatasource _sqlDatasource;

  const CacheRepository(this._prefsDatasource, this._sqlDatasource);

  @override
  Future<GetCacheResponse<T>> get<T extends Object>(
    GetCacheDTO dto,
  ) async {
    try {
      final action = dto.storageType.isPrefs ? _prefsDatasource.get : _sqlDatasource.get;

      final response = await action.call<T>(dto.key);

      return right(response);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }

  @override
  Future<Either<AutoCacheManagerException, Unit>> save<T extends Object>(
    SaveCacheDTO<T> dto,
  ) async {
    try {
      final action = dto.storageType.isPrefs ? _prefsDatasource.save : _sqlDatasource.save;

      await action.call<T>(dto);

      return right(unit);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }

  @override
  Future<Either<AutoCacheManagerException, Unit>> clear(ClearCacheDTO dto) async {
    try {
      final action = dto.storageType.isPrefs ? _prefsDatasource.clear : _sqlDatasource.clear;

      await action.call();

      return right(unit);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }
}
