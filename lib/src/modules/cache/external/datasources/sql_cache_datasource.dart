import 'dart:async';

import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';
import '../../infra/datasources/i_sql_cache_datasource.dart';

final class SQLCacheDatasource implements ISQLCacheDatasource {
  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<CacheEntity<T>?> findByKey<T extends Object>(String key) {
    // TODO: implement findByKey
    throw UnimplementedError();
  }

  @override
  Future<void> save<T extends Object>(SaveCacheDTO<T> dto) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
