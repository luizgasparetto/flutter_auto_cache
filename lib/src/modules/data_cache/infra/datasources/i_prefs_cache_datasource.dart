import 'dart:async';

import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';

abstract interface class IPrefsCacheDatasource {
  CacheEntity<T>? get<T extends Object>(String key);
  List<String> getKeys();

  Future<void> save<T extends Object>(SaveCacheDTO<T> dto);
  Future<void> clear();
}
