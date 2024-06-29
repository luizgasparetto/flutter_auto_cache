import '../../../../core/core.dart';

import '../../domain/dtos/delete_cache_dto.dart';
import '../../domain/dtos/get_cache_dto.dart';
import '../../domain/dtos/update_cache_dto.dart';
import '../../domain/dtos/write_cache_dto.dart';
import '../../domain/entities/data_cache_entity.dart';
import '../../domain/repositories/i_data_cache_repository.dart';

import '../datasources/data_cache/i_command_data_cache_datasource.dart';
import '../datasources/data_cache/i_query_data_cache_datasource.dart';

class DataCacheRepository implements IDataCacheRepository {
  final IQueryDataCacheDatasource _queryDataCacheDatasource;
  final ICommandDataCacheDatasource _commandDataCacheDatasource;

  const DataCacheRepository(this._queryDataCacheDatasource, this._commandDataCacheDatasource);

  @override
  Either<AutoCacheException, DataCacheEntity<T>?> get<T extends Object>(GetCacheDTO dto) {
    try {
      final response = _queryDataCacheDatasource.get<T>(dto.key);

      return right(response);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  Either<AutoCacheException, DataCacheEntity<T>?> getList<T extends Object, DataType extends Object>(GetCacheDTO dto) {
    try {
      final response = _queryDataCacheDatasource.getList<T, DataType>(dto.key);

      return right(response);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  Either<AutoCacheException, List<String>> getKeys() {
    try {
      final response = _queryDataCacheDatasource.getKeys();

      return right(response);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheException, Unit> save<T extends Object>(WriteCacheDTO<T> dto) async {
    try {
      await _commandDataCacheDatasource.save<T>(dto);

      return right(unit);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheException, Unit> update<T extends Object>(UpdateCacheDTO<T> dto) async {
    try {
      await _commandDataCacheDatasource.update<T>(dto);

      return right(unit);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheException, Unit> delete(DeleteCacheDTO dto) async {
    try {
      await _commandDataCacheDatasource.delete(dto.key);

      return right(unit);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheException, Unit> clear() async {
    try {
      await _commandDataCacheDatasource.clear();

      return right(unit);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }
}
