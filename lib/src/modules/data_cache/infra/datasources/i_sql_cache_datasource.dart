import 'dart:async';

import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';

abstract interface class ISQLCacheDatasource {
  FutureOr<CacheEntity<T>?> get<T extends Object>(String key);
  FutureOr<List<String>> getKeys();

  Future<void> save<T extends Object>(SaveCacheDTO<T> dto);
  Future<void> delete(String key);
  Future<void> clear();
}
