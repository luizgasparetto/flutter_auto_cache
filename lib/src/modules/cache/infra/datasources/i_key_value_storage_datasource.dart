import '../../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';

abstract interface class IKeyValueStorageDatasource {
  CacheEntity<T>? findByKey<T>(String key);
  Future<void> save<T>(SaveCacheDTO dto);
}
