import '../../../../core/services/storages/kvs/i_key_value_storage_service.dart';

import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';
import '../../infra/datasources/i_key_value_storage_datasource.dart';
import '../adapters/cache_adapter.dart';

class KeyValueStorageDatasource implements IKeyValueStorageDatasource {
  final IKeyValueStorageService _service;

  const KeyValueStorageDatasource(this._service);

  @override
  CacheEntity<T>? findByKey<T extends Object>(String key) {
    final response = _service.get<T>(key: key);

    if (response == null) return null;

    return CacheAdapter.fromDto<T>(response);
  }

  @override
  Future<void> save<T extends Object>(SaveCacheDTO<T> dto) async {
    await _service.save<T>(key: dto.key, data: dto.data);
  }

  @override
  Future<void> clear() async {
    return _service.clear();
  }
}
