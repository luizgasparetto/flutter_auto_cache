import 'dart:async';

import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';

abstract interface class ISQLStorageDatasource {
  FutureOr<CacheEntity<T>?> findByKey<T extends Object>(String key);
  Future<void> save<T extends Object>(SaveCacheDTO<T> dto);
}
