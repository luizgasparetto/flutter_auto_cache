import 'dart:async';

import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';
import '../../infra/datasources/i_sql_cache_datasource.dart';

final class SQLCacheDatasource implements ISQLCacheDatasource {
  @override
  Future<CacheEntity<T>?> get<T extends Object>(String key) {
    throw UnimplementedError();
  }

  @override
  FutureOr<List<String>> getKeys() {
    throw UnimplementedError();
  }

  @override
  Future<void> save<T extends Object>(SaveCacheDTO<T> dto) {
    throw UnimplementedError();
  }

  @override
  Future<void> clear() {
    throw UnimplementedError();
  }
}
