import '../../../../core/core.dart';
import '../../../../core/functional/either.dart';

import '../../domain/dtos/key_cache_dto.dart';
import '../../domain/dtos/update_cache_dto.dart';
import '../../domain/dtos/write_cache_dto.dart';
import '../../domain/entities/data_cache_entity.dart';
import '../../domain/repositories/i_data_cache_repository.dart';
import '../datasources/i_command_data_cache_datasource.dart';
import '../datasources/i_query_data_cache_datasource.dart';

class DataCacheRepository implements IDataCacheRepository {
  final IQueryDataCacheDatasource queryDatasource;
  final ICommandDataCacheDatasource commandDatasource;

  const DataCacheRepository(this.queryDatasource, this.commandDatasource);

  @override
  Either<AutoCacheException, DataCacheEntity<T>?> get<T extends Object>(KeyCacheDTO dto) {
    try {
      final response = queryDatasource.get<T>(dto.key);

      return right(response);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  Either<AutoCacheException, DataCacheEntity<T>?> getList<T extends Object, DataType extends Object>(KeyCacheDTO dto) {
    try {
      final response = queryDatasource.getList<T, DataType>(dto.key);

      return right(response);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  Either<AutoCacheException, List<String>> getKeys() {
    try {
      final response = queryDatasource.getKeys();

      return right(response);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheException, bool> accomodateCache<T extends Object>(DataCacheEntity<T> cache, {bool recursive = false}) async {
    try {
      final response = await queryDatasource.accomodateCache(cache);

      return right(response);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheException, Unit> save<T extends Object>(WriteCacheDTO<T> dto) async {
    try {
      await commandDatasource.save<T>(dto);

      return right(unit);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheException, Unit> update<T extends Object>(UpdateCacheDTO<T> dto) async {
    try {
      await commandDatasource.update<T>(dto);

      return right(unit);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheException, Unit> delete(KeyCacheDTO dto) async {
    try {
      await commandDatasource.delete(dto.key);

      return right(unit);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }

  @override
  AsyncEither<AutoCacheException, Unit> clear() async {
    try {
      await commandDatasource.clear();

      return right(unit);
    } on AutoCacheException catch (exception) {
      return left(exception);
    }
  }
}
