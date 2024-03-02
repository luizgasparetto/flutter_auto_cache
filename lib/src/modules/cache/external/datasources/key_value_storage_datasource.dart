import '../../../../core/services/kvs/i_storage_service.dart';
import '../../../domain/dtos/save_cache_dto.dart';
import '../../domain/entities/cache_entity.dart';
import '../../infra/datasources/i_key_value_storage_datasource.dart';

class KeyValueStorageDatasource implements IKeyValueStorageDatasource {
  final IKeyValueStorageService _service;

  const KeyValueStorageDatasource(this._service);

  @override
  CacheEntity<T>? findByKey<T>(String key) {
    final response = _service.get<T>(key: key);
    throw UnimplementedError();
  }

  @override
  Future<void> save<T>(SaveCacheDTO dto) async {
    await _service.save<T>(key: dto.key, value: dto.data);
    throw UnimplementedError();
  }
}
